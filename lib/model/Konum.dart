class Konum {
  Konum(this.sehirAdi, this.ilceAdi);

  factory Konum.fromJson(Map<String, Object?> json) {
    return Konum(
      // JSON'dan 'sehir_adi' değerini alıyoruz
      json['il'] is String ? json['il']! as String : 'No City', // Eğer sehir_adi yoksa 'No City' döndür
      // JSON'dan 'ilce_adi' değerini alıyoruz
      json['ilce'] is String ? json['ilce']! as String : 'No District', // Eğer ilce_adi yoksa 'No District' döndür
    );
  }

  String sehirAdi;
  String ilceAdi;
}
