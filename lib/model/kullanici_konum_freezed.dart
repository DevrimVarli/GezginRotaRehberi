import 'package:freezed_annotation/freezed_annotation.dart';

part 'kullanici_konum_freezed.freezed.dart';
part 'kullanici_konum_freezed.g.dart'; // JSON serialization için

@freezed
abstract class KullaniciKonumFreezed with _$KullaniciKonumFreezed {
  // Kullanıcı konumu için gerekli tüm parametreleri içeren factory constructor
  const factory KullaniciKonumFreezed({
    required String disyplayName,    // Adresin görüntülenecek adı
    required String binaNo,          // Bina numarası
    required String katNo,           // Kat numarası
    required String daireNo,         // Daire numarası
    required String adresTarifi,     // Adres tarifi
    required String adresBasligi,    // Adres başlığı
    required String ad,               // Kullanıcı adı
    required String soyad,            // Kullanıcı soyadı
    required String cepTelefonu,      // Kullanıcı telefon numarası
    required String sokakAdi,         // Sokak adı
    required String mahalleAdi,       // Mahalle adı
    required String ilceAdi,          // İlçe adı
    required String sehirAdi,         // Şehir adı
    @Default(false) bool isActive,    // Aktiflik durumu (varsayılan değeri 'false')
  }) = _KullaniciKonumFreezed;

  // JSON'dan KullaniciKonumFreezed nesnesi oluşturma işlemi
  factory KullaniciKonumFreezed.fromJson(Map<String, dynamic> json) => _$KullaniciKonumFreezedFromJson(json);
}
