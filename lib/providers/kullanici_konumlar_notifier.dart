import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/kullanici_konum.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

class KullaniciKonumlarNotifier extends StateNotifier<List<KullaniciKonumFreezed>> {
  KullaniciKonumlarNotifier() : super([]);

  void add(KullaniciKonumFreezed yeni) {
    state = [...state, yeni];
  }

  void update(KullaniciKonumFreezed guncelKonum) {
    state = [
      for (final konum in state)
        if (konum.adresBasligi == guncelKonum.adresBasligi) guncelKonum else konum
    ];
  }
}