import 'package:hive_ce/hive.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

@GenerateAdapters(
    firstTypeId: 0,
    [
  AdapterSpec<KullaniciKonumFreezed>(),
])
part 'hive_adapters.g.dart';