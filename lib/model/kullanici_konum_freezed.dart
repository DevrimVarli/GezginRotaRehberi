import 'package:freezed_annotation/freezed_annotation.dart';

part 'kullanici_konum_freezed.freezed.dart';
part 'kullanici_konum_freezed.g.dart'; // JSON serialization için

@freezed
abstract class KullaniciKonumFreezed with _$KullaniciKonumFreezed {
  const factory KullaniciKonumFreezed({
    required String disyplayName,
    required String binaNo,
    required String katNo,
    required String daireNo,
    required String adresTarifi,
    required String adresBasligi,
    required String ad,
    required String soyad,
    required String cepTelefonu,
    required String sokakAdi,
    required String mahalleAdi,
    required String ilceAdi,
    required String sehirAdi,
    @Default(false) bool isActive,
  }) = _KullaniciKonumFreezed;

  factory KullaniciKonumFreezed.fromJson(Map<String, dynamic> json) => _$KullaniciKonumFreezedFromJson(json);
}