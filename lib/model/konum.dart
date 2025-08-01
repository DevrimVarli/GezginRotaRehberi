class Konum {
  // Constructor: Konum sınıfının bir örneğini oluşturmak için kullanılan parametreler
  Konum(this.sehirAdi, this.ilceAdi);

  // Factory constructor: JSON verisinden Konum nesnesi oluşturmak için kullanılır
  factory Konum.fromJson(Map<String, Object?> json) {
    return Konum(
      // JSON'dan 'il' değerini alıyoruz. Eğer değer doğru türde değilse 'No City' döndürüyoruz.
      json['il'] is String ? json['il']! as String : 'No City',

      // JSON'dan 'ilce' değerini alıyoruz. Eğer değer doğru türde değilse 'No District' döndürüyoruz.
      json['ilce'] is String ? json['ilce']! as String : 'No District',
    );
  }

  // Konumun her bileşeni için özellikler
  String sehirAdi; // Şehir adı
  String ilceAdi; // İlçe adı
}
