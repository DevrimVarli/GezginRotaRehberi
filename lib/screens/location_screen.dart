import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/adres_yaniti.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/repository/adres_repo.dart';
import 'package:yeni_tasarim/screens/adres_ekleme_screen.dart';

class KonumSecPage extends ConsumerStatefulWidget {

  const KonumSecPage({super.key});

  @override
  ConsumerState<KonumSecPage> createState() => _KonumSecPageState();
}

class _KonumSecPageState extends ConsumerState<KonumSecPage> {
  Position? secilenKonum;

  @override
  void initState() {
    super.initState();
    baslangicKonumunuAl();
  }

  Future<void> baslangicKonumunuAl() async {
    Position? konum = await ref.read(locationProvider).konumuAl();
    if (konum != null) {
      setState(() {
        secilenKonum = konum;
        ref.read(baslangicKonumuProvider.notifier).state = LatLng(konum.latitude, konum.longitude);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     LatLng? secilenKonumLatLng = ref.watch(secilenKonumuProviderLatLng);
     LatLng? baslangicKonum = ref.watch(baslangicKonumuProvider);

    if (baslangicKonum == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Konum Seç')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: baslangicKonum,
          onTap: (TapPosition tapPosition, LatLng point) async {
            ref
                .read(secilenKonumuProviderLatLng.notifier)
                .state = point;

            Konum konum = await loca().konumuver(
                point.latitude, point.longitude);

            print("İl: ${konum.sehirAdi}");
            print("İlçe: ${konum.ilceAdi}");
            print("Lat: ${point.latitude}");
            print("Lng: ${point.longitude}");
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.uygulaman',
          ),
          if (secilenKonumLatLng != null)
            MarkerLayer(
              markers: <Marker>[
                Marker(
                  point: secilenKonumLatLng,
                  width: 80,
                  height: 80,
                  child: const Icon(
                      Icons.location_pin, size: 40, color: Colors.red),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          if (secilenKonumLatLng != null) {
            AdresRepo adresRepo=AdresRepo();
            AdresYaniti adresYaniti=await adresRepo.konumGetir(secilenKonumLatLng.latitude, secilenKonumLatLng.longitude) ;
            Konum konum=Konum(adresYaniti.adres.sehirAdi,adresYaniti.adres.ilceAdi);
            //ref.read(kullaniciKonumlarProvider.notifier).state.add(KullaniciKonum(disyplayName: adresYaniti.displayName, binaNo: adresYaniti.adres.binaNo, katNo: adresYaniti.katNo, daireNo: daireNo, adresTarifi: adresTarifi, adresBasligi: adresBasligi, ad: ad, soyad: soyad, cepTelefonu: cepTelefonu, sokakAdi: sokakAdi, mahalleAdi: mahalleAdi, ilceAdi: ilceAdi, sehirAdi: sehirAdi));
            //KullaniciKonum kullaniciKonum=KullaniciKonum(disyplayName: adresYaniti.displayName,binaNo: adresYaniti.adres.);
            await Navigator.pushReplacement(context, MaterialPageRoute<Widget>(builder: (BuildContext context)=>AdresScreenDetay(adresAdi:adresYaniti.displayName,ilAdi: konum.sehirAdi,ilceAdi: konum.ilceAdi,mahalleAdi: adresYaniti.adres.mahalleAdi,sokakAdi: adresYaniti.adres.sokakAdi)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Lütfen bir konum seçin')),
            );
          }
        },
        label: const Text('Seç ve Dön'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}

  class loca {
  loca();

  Future<Konum> konumuver(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks.first;
    return Konum(place.administrativeArea.toString(), place.subAdministrativeArea.toString());
  }
}
