import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/model/konum.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/adres_ekleme_screen.dart';
import 'package:yeni_tasarim/screens/location_screen.dart';

/// Kullanıcının kayıtlı teslimat adreslerini listeleyen ekran.
/// Yeni konum ekleme, mevcut konumu kullanma ve adres düzenleme/silme işlemleri yapılabilir.
class AdresScreen extends ConsumerWidget {
  const AdresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hive'da tutulan kayıtlı adresler
    Box<KullaniciKonumFreezed> box = Hive.box<KullaniciKonumFreezed>(
      'konumlar',
    );

    // Tema bilgileri
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'address_info'.tr(),
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Açıklama metni
              Text(
                'address_description'.tr(),
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),

              // Mevcut konumu kullan butonu
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  ),
                  onPressed: () {
                    // TODO: Mevcut konum alma işlevi buraya gelecek
                  },
                  icon: const Icon(Icons.zoom_in_map, color: Colors.white),
                  label: Text(
                    'use_current_location'.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // Yeni konum seç butonu
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => const KonumSecPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.location_on, color: Colors.white),
                  label: Text(
                    'choose_new_location'.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // Kayıtlı adres listesi
              Expanded(
                child: ValueListenableBuilder<Box<KullaniciKonumFreezed>>(
                  valueListenable: box.listenable(),
                  builder: (
                    BuildContext context,
                    Box<KullaniciKonumFreezed> value,
                    Widget? child,
                  ) {
                    List<KullaniciKonumFreezed> adresListesi =
                        value.values.toList();

                    if (adresListesi.isEmpty) {
                      return Center(child: Text('no_address_description'.tr()));
                    }

                    return ListView.builder(
                      itemCount: adresListesi.length,
                      itemBuilder: (BuildContext context, int indeks) {
                        KullaniciKonumFreezed konum = adresListesi[indeks];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              // Seçili konumu provider üzerinden güncelle
                              ref
                                  .read(secilemKonumStateProvider.notifier)
                                  .state = Konum(konum.sehirAdi, konum.ilceAdi);
                              Navigator.pop(context);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: colorScheme.surface,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Başlık + Düzenle butonu
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          konum.adresBasligi,
                                          style: textTheme.titleLarge,
                                        ),
                                        const Spacer(),
                                        TextButton.icon(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute<Widget>(
                                                builder:
                                                    (BuildContext context) =>
                                                        AdresScreenDetay(
                                                          kullaniciKonum: konum,
                                                        ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: Text('edit'.tr()),
                                        ),
                                      ],
                                    ),

                                    // Adres bilgileri
                                    Text(
                                      '${konum.mahalleAdi} Mah / ${konum.sehirAdi} / ${konum.ilceAdi}',
                                      style: textTheme.titleMedium,
                                    ),
                                    Text(
                                      '${konum.mahalleAdi} Mah / ${konum.sokakAdi} Sokak',
                                      style: textTheme.titleSmall?.copyWith(
                                        color: colorScheme.onSurface.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Bina No: ${konum.binaNo} / Kat: ${konum.katNo} / Daire: ${konum.daireNo}',
                                      style: textTheme.titleSmall,
                                    ),

                                    // Telefon + Sil butonu
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          konum.cepTelefonu,
                                          style: textTheme.titleSmall,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Silme işleminde kullanıcı onayı iste
                                            box.delete(konum.adresBasligi);
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
