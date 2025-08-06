import 'package:dio/dio.dart';

import 'package:yeni_tasarim/model/adres_bilgisi.dart';
import 'package:yeni_tasarim/model/adres_yaniti.dart';
import 'package:yeni_tasarim/model/konum.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

/// Adres verileriyle ilgili işlemleri yöneten repository sınıfı.
/// Konum listesi, kullanıcı konum listesi, API’den konum bilgisi çekme gibi görevleri yapar.
class AdresRepo {
  /// HTTP istekleri için Dio nesnesi
  final Dio dio = Dio();

  /// Tüm şehir/ilçe konum listesi
  List<Konum> konumList = <Konum>[];

  /// Kullanıcının kaydettiği konum listesi
  List<KullaniciKonumFreezed> kullaniciKonumList = <KullaniciKonumFreezed>[];

  /// Statik olarak birkaç konum ekler ve geri döner
  List<Konum> konumlar() {
    Konum konum1 = Konum('Bursa', 'Osmangazi');
    Konum konum2 = Konum('Bursa', 'Nilüfer');
    Konum konum3 = Konum('Bursa', 'Mudanya');

    konumList
      ..add(konum1)
      ..add(konum2)
      ..add(konum3);

    return konumList;
  }

  /// Örnek kullanıcı konum listesi oluşturur
  List<KullaniciKonumFreezed> kullaniciKonumkonumlar() {
    KullaniciKonumFreezed konum1 = const KullaniciKonumFreezed(
      disyplayName: 'Devrim',
      binaNo: '52',
      katNo: '3',
      daireNo: '5',
      adresTarifi: 'dsadadasd',
      adresBasligi: 'evim',
      ad: 'Devrim',
      soyad: 'Varli',
      cepTelefonu: '05415865175',
      sokakAdi: '424',
      mahalleAdi: 'Gölcük',
      ilceAdi: 'Menemen',
      sehirAdi: 'İzmir',
    );

    kullaniciKonumList.add(konum1);
    return kullaniciKonumList;
  }

  /// Yeni bir konum ekler
  List<Konum> konumEkle(Konum konum) {
    konumList.add(konum);
    return konumList;
  }

  /// Var olan konumu listeden siler
  List<Konum> konumSil(Konum konum) {
    konumList.remove(konum);
    return konumList;
  }

  /// Verilen latitude & longitude bilgisine göre
  /// OpenStreetMap Nominatim API’sinden adres bilgisi getirir.
  /// Dönüş tipi: AdresYaniti (adres modeli + displayName)
  Future<AdresYaniti> konumGetir(double latitude, double longitude) async {
    Response<dynamic> response = await dio.get(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude',
      options: Options(
        headers: <String, dynamic>{
          // API kullanımında kimlik bilgisi olarak user-agent eklenmesi gerekir
          'User-Agent': 'com.example.myflutterapp/1.0 (melikenr_kya@gmail.com)',
        },
      ),
    );

    if (response.statusCode == 200) {
      // API’den dönen veriyi Map olarak al
      Map<String, dynamic> data = response.data as Map<String, dynamic>;

      // Adres bilgilerini ayıkla
      Map<String, dynamic> address = data['address'] as Map<String, dynamic>;
      String display = data['display_name']?.toString() ?? 'İsim bulunamadı';

      // Model sınıfına dönüştür
      AdresBilgisi adresModel = AdresBilgisi.fromJson(address);

      return AdresYaniti(adres: adresModel, displayName: display);
    } else {
      throw Exception('Konum bilgisi alınamadı');
    }
  }
}
