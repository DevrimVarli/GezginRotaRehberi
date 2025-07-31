import 'package:dio/dio.dart';
import 'package:yeni_tasarim/model/Konum.dart';

import 'package:yeni_tasarim/model/adres_bilgisi.dart';
import 'package:yeni_tasarim/model/adres_yaniti.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

class AdresRepo{
  final Dio dio=Dio();
  List<Konum>konumList=<Konum>[];
  List<KullaniciKonumFreezed>kullaniciKonumList=<KullaniciKonumFreezed>[];
  List<Konum>  konumlar(){
    Konum konum1 = Konum('Bursa', 'Osmangazi');
    Konum konum2 = Konum('Bursa', 'Nilüfer');
    Konum konum3 = Konum('Bursa', 'Mudanya');
    konumList..add(konum1)
    ..add(konum2)
    ..add(konum3);
    return konumList;
  }List<KullaniciKonumFreezed>  kullaniciKonumkonumlar(){
    KullaniciKonumFreezed konum1 = const KullaniciKonumFreezed(disyplayName: 'Devrim',binaNo: '52', katNo: '3', daireNo: '5', adresTarifi: 'dsadadasd', adresBasligi: 'evim', ad: 'Devrim', soyad: 'Varli', cepTelefonu: '05415865175', sokakAdi: '424', mahalleAdi: 'Gölcük', ilceAdi: 'Menemen', sehirAdi: 'İzmir');
    kullaniciKonumList.add(konum1);
    return kullaniciKonumList;
  }
  List<Konum> konumEkle(Konum konum){
    konumList.add(konum);
    return konumList;
  }
  List<Konum> konumSil(Konum konum){
    konumList.remove(konum);
    return konumList;
  }
  Future<AdresYaniti> konumGetir(double latitude, double longitude) async {
    Response<dynamic> response = await dio.get(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude',
      options: Options(
        headers: <String,dynamic >{
          'User-Agent': 'com.example.myflutterapp/1.0 (melikenr_kya@gmail.com)',
        },
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;

      Map<String, dynamic> address = data['address'] as Map<String, dynamic>;
      String display = data['display_name']?.toString() ?? 'İsim bulunamadı';

      AdresBilgisi adresModel = AdresBilgisi.fromJson(address);
      return AdresYaniti(adres: adresModel, displayName: display);
    } else {
      throw Exception('Konum bilgisi alınamadı');
    }

  }


}
