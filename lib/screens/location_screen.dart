import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:yeni_tasarim/model/konum.dart';
import 'package:yeni_tasarim/model/adres_yaniti.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/repository/adres_repo.dart';
import 'package:yeni_tasarim/screens/adres_ekleme_screen.dart';

/// Harita üzerinde konum seçme ekranı.
/// - Uygulama açıldığında cihazın mevcut konumunu alır.
/// - Kullanıcı haritadan başka bir konuma dokunarak seçim yapabilir.
/// - Seçilen konumun adres bilgisi `AdresRepo` ile alınır ve adres düzenleme ekranına yönlendirilir.
class KonumSecPage extends ConsumerStatefulWidget {
  const KonumSecPage({super.key});

  @override
  ConsumerState<KonumSecPage> createState() => _KonumSecPageState();
}

class _KonumSecPageState extends ConsumerState<KonumSecPage>
    with WidgetsBindingObserver {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _baslangicKonumunuAl();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      isLoading = true;
      setState(() {});
      //print('📲 Uygulama ayarlardan geri döndü');

      // Konum servisleri açılmış mı kontrol et
      Geolocator.isLocationServiceEnabled().then((bool enabled) async {
        if (enabled) {
          // print('✅ Konum servisi artık açık');
          await _baslangicKonumunuAl();
        } else {
          //print('❌ Konum servisi hâlâ kapalı');
          if (!mounted) return;
          Navigator.pop(context);
        }
      });
    }
  }

  /// Cihazın mevcut konumunu alır ve provider'lara set eder.
  Future<void> _baslangicKonumunuAl() async {
    Position? konum = await ref.read(locationProvider).konumuAl();
    if (!mounted) return;

    if (konum != null) {
      LatLng latLng = LatLng(konum.latitude, konum.longitude);
      ref.read(baslangicKonumuProvider.notifier).state = latLng;
      ref.read(secilenKonumuProviderLatLng.notifier).state = latLng;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    LatLng? secilenKonumLatLng = ref.watch(secilenKonumuProviderLatLng);
    LatLng? baslangicKonum = ref.watch(baslangicKonumuProvider);

    // Konum yüklenene kadar gösterilecek ekran
    if (baslangicKonum == null || isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text('choose_location'.tr()),
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
          // Harita ilk açıldığında başlangıç konumunu göster
          initialCenter: LatLng(
            baslangicKonum.latitude,
            baslangicKonum.longitude,
          ),

          // Haritaya dokunulduğunda seçilen konumu güncelle
          onTap: (TapPosition tapPosition, LatLng point) {
            ref.read(secilenKonumuProviderLatLng.notifier).state = point;
          },
        ),
        children: <Widget>[
          // Harita katmanı
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.yeni_tasarim',
          ),

          // Seçilen konumu işaretle
          if (secilenKonumLatLng != null)
            MarkerLayer(
              markers: <Marker>[
                Marker(
                  point: secilenKonumLatLng,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
        ],
      ),

      // Konumu seçme butonu
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorScheme.primary,
        onPressed: () async {
          if (secilenKonumLatLng != null) {
            // Adres bilgisini al
            AdresRepo adresRepo = AdresRepo();
            AdresYaniti adresYaniti = await adresRepo.konumGetir(
              secilenKonumLatLng.latitude,
              secilenKonumLatLng.longitude,
            );

            // Sehir ve ilçe bilgilerini modele aktar
            Konum konum = Konum(
              adresYaniti.adres.sehirAdi,
              adresYaniti.adres.ilceAdi,
            );

            if (!context.mounted) return;

            // Adres düzenleme ekranına yönlendir
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute<Widget>(
                builder:
                    (BuildContext context) => AdresScreenDetay(
                      adresAdi: adresYaniti.displayName,
                      ilAdi: konum.sehirAdi,
                      ilceAdi: konum.ilceAdi,
                      mahalleAdi: adresYaniti.adres.mahalleAdi,
                      sokakAdi: adresYaniti.adres.sokakAdi,
                    ),
              ),
            );
          } else {
            // Konum seçilmediyse uyarı
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Lütfen bir konum seçin')),
            );
          }
        },
        label: const Text('select_and_return').tr(),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
