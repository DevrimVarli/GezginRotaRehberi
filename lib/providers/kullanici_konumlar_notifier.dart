import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

class KullaniciKonumlarNotifier extends StateNotifier<List<KullaniciKonumFreezed>> {
  KullaniciKonumlarNotifier() : super(<KullaniciKonumFreezed>[]);

  void add(KullaniciKonumFreezed yeni) {
    state = <KullaniciKonumFreezed>[...state, yeni];
  }

  void update(KullaniciKonumFreezed guncelKonum) {
    state = <KullaniciKonumFreezed>[
      for (final KullaniciKonumFreezed konum in state)
        if (konum.adresBasligi == guncelKonum.adresBasligi) guncelKonum else konum,
    ];
  }
}
