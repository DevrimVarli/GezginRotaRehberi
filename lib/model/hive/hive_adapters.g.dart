// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class KullaniciKonumFreezedAdapter extends TypeAdapter<KullaniciKonumFreezed> {
  @override
  final int typeId = 0;

  @override
  KullaniciKonumFreezed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KullaniciKonumFreezed(
      disyplayName: fields[0] as String,
      binaNo: fields[1] as String,
      katNo: fields[2] as String,
      daireNo: fields[3] as String,
      adresTarifi: fields[4] as String,
      adresBasligi: fields[5] as String,
      ad: fields[6] as String,
      soyad: fields[7] as String,
      cepTelefonu: fields[8] as String,
      sokakAdi: fields[9] as String,
      mahalleAdi: fields[10] as String,
      ilceAdi: fields[11] as String,
      sehirAdi: fields[12] as String,
      isActive: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, KullaniciKonumFreezed obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.disyplayName)
      ..writeByte(1)
      ..write(obj.binaNo)
      ..writeByte(2)
      ..write(obj.katNo)
      ..writeByte(3)
      ..write(obj.daireNo)
      ..writeByte(4)
      ..write(obj.adresTarifi)
      ..writeByte(5)
      ..write(obj.adresBasligi)
      ..writeByte(6)
      ..write(obj.ad)
      ..writeByte(7)
      ..write(obj.soyad)
      ..writeByte(8)
      ..write(obj.cepTelefonu)
      ..writeByte(9)
      ..write(obj.sokakAdi)
      ..writeByte(10)
      ..write(obj.mahalleAdi)
      ..writeByte(11)
      ..write(obj.ilceAdi)
      ..writeByte(12)
      ..write(obj.sehirAdi)
      ..writeByte(13)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KullaniciKonumFreezedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
