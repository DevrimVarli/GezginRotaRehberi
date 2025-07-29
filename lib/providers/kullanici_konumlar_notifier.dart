import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/kullanici_konum.dart';

class KullaniciKonumlarNotifier extends StateNotifier<List<KullaniciKonum>> {
  KullaniciKonumlarNotifier() : super([]);

  void add(KullaniciKonum yeni) {
    state = [...state, yeni];
  }

  void update(KullaniciKonum guncelKonum) {
    state = [
      for (final konum in state)
        if (konum.adresBasligi == guncelKonum.adresBasligi) guncelKonum else konum
    ];
  }
}