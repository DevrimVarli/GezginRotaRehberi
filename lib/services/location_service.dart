import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:yeni_tasarim/model/konum.dart';

//
class LocationService{
  Future<Konum> getCurrentCityAndDistrict() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Konum('sehirAdi', 'ilceAdi');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return Konum('sehirAdi', 'ilceAdi');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        timeLimit: Duration(seconds: 10),
      ),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    return Konum(place.administrativeArea.toString(), place.subAdministrativeArea.toString());
  }

//latitude ve longitude enlem-boylam konumudur (harita uygulamaları gibi kullanılabilir).
  Future<Position?> konumuAl() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // Konum servisleri kapalıysa, kullanıcıyı yönlendir ve tekrar kontrol et
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        serviceEnabled = await Geolocator.isLocationServiceEnabled(); // tekrar kontrol!
        if (!serviceEnabled) {
          await Fluttertoast.showToast(msg: 'Konum servisleri hala kapalı.');
          return null;
        }
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await Fluttertoast.showToast(msg: 'Konum izni reddedildi.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        await Fluttertoast.showToast(msg: 'Konum izni kalıcı olarak reddedildi.');
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
      await Fluttertoast.showToast(msg: 'Konum alınamadı: $e');
      return null;
    }
  }


}
