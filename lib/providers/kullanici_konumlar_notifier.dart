import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

/// Kullanıcı konumlarını yöneten StateNotifier sınıfı.
/// State tipi: List<.KullaniciKonumFreezed>
/// Başlangıç değeri: boş list
class KullaniciKonumlarNotifier extends StateNotifier<List<KullaniciKonumFreezed>> {

  /// Constructor — boş liste ile başlatır
  KullaniciKonumlarNotifier() : super(<KullaniciKonumFreezed>[]);

  /// Yeni bir konum ekler.
  /// Mevcut state listesini kopyalar ve yeni elemanı ekler.
  void add(KullaniciKonumFreezed yeni) {
    state = <KullaniciKonumFreezed>[...state, yeni];
  }

  /// Var olan bir konumu günceller.
  /// Güncelleme, adresBaşlığı alanı eşleşen konum üzerinden yapılır.
  /// Eğer adresBaşlığı aynı ise, yeni gelen `guncelKonum` ile değiştirir.
  void update(KullaniciKonumFreezed guncelKonum) {
    state = <KullaniciKonumFreezed>[
      for (final KullaniciKonumFreezed konum in state)
        if (konum.adresBasligi == guncelKonum.adresBasligi)
          guncelKonum
        else
          konum,
    ];
  }
}
