import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:yeni_tasarim/model/konum.dart';

/// Cihazın konumunu almak ve şehir / ilçe bilgisine dönüştürmek için servis.
/// `Geolocator` ve `Geocoding` paketlerini kullanır.
class LocationService {
  /// Kullanıcının bulunduğu şehir ve ilçeyi döndürür.
  /// Eğer konum servisleri kapalı veya izinler reddedilmişse varsayılan değer döner.
  Future<Konum> getCurrentCityAndDistrict() async {
    // Konum servisleri açık mı kontrol et
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Konum('sehirAdi', 'ilceAdi'); // Varsayılan değer
    }

    // Konum izni kontrolü
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // İzin isteme
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return Konum('sehirAdi', 'ilceAdi'); // Varsayılan değer
      }
    }

    // Kullanıcının mevcut konumunu al
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        timeLimit: Duration(seconds: 10),
      ),
    );

    // Koordinatları adrese çevir
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // İlk bulunan adres bilgilerini kullan
    Placemark place = placemarks.first;

    return Konum(
      place.administrativeArea.toString(), // Şehir
      place.subAdministrativeArea.toString(), // İlçe
    );
  }

  /// Latitude ve longitude bilgisini döndürür (enlem-boylam).
  /// Harita uygulamaları gibi kullanılabilir.
  /// İzin kontrolü yapar, kullanıcıyı gerekli ayarlara yönlendirir.
  Future<Position?> konumuAl() async {
    try {
      // Konum servisleri açık mı?
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // Kapalı ise ayarlara yönlendir
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        serviceEnabled = await Geolocator.isLocationServiceEnabled(); // tekrar kontrol et
        if (!serviceEnabled) {
          await Fluttertoast.showToast(msg: 'Konum servisleri hala kapalı.');
          return null;
        }
      }

      // Konum izni kontrolü
      LocationPermission permission = await Geolocator.checkPermission();

      // İlk izin isteği
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await Fluttertoast.showToast(msg: 'Konum izni reddedildi.');
          return null;
        }
      }

      // Kalıcı reddedilmiş izin durumu
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        await Fluttertoast.showToast(
            msg: 'Konum izni kalıcı olarak reddedildi.',);
        return null;
      }

      // Her şey yolunda → gerçek konumu döndür
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (e) {
      // Beklenmedik hata
      await Fluttertoast.showToast(msg: 'Konum alınamadı: $e');
      return null;
    }
  }
}
