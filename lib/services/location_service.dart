import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

/// Cihazın konumunu almak ve şehir / ilçe bilgisine dönüştürmek için servis.
/// `Geolocator` ve `Geocoding` paketlerini kullanır.
class LocationService {
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
        serviceEnabled =
            await Geolocator.isLocationServiceEnabled(); // tekrar kontrol et
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
          msg: 'Konum izni kalıcı olarak reddedildi.',
        );
        return null;
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // İzin verildiyse gerçek konumu al
        return await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
            timeLimit: Duration(seconds: 10),
          ),
        );
      } else if (permission == LocationPermission.unableToDetermine) {
        await Fluttertoast.showToast(msg: 'Konum izni belirlenemedi.');
        return null;
      } else {
        await Fluttertoast.showToast(msg: 'Konum izni alınamadı.');
        return null;
      }
    } catch (e) {
      // Beklenmedik hata
      await Fluttertoast.showToast(msg: 'Konum alınamadı: $e');
      return null;
    }
  }
}
