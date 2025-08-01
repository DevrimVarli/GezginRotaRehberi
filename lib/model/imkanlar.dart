class Imkanlar {
  // Constructor: Imkanlar sınıfının bir örneğini oluşturmak için kullanılan parametreler
  Imkanlar(this.imkanID, this.imkanAdi, this.imkanIcon);

  // Factory constructor: JSON verisinden Imkanlar nesnesi oluşturmak için kullanılır
  factory Imkanlar.fromJson(Map<String, Object?> json) {
    return Imkanlar(
      // JSON'dan gelen 'imkan_id' değerini int türüne dönüştürür. Eğer değer doğru türde değilse 0 döndürür.
      json['imkan_id'] is int ? json['imkan_id']! as int : 0,

      // JSON'dan gelen 'imkan_ad' değerini String türüne dönüştürür. Eğer değer doğru türde değilse 'No Name' döndürür.
      json['imkan_ad'] is String ? json['imkan_ad']! as String : 'No Name',

      // JSON'dan gelen 'imkan_icon' değerini String türüne dönüştürür. Eğer değer doğru türde değilse 'default_icon' döndürür.
      json['imkan_icon'] is String ? json['imkan_icon']! as String : 'default_icon',
    );
  }

  // İmkanların her biri için özellikler
  int imkanID; // İmkanın benzersiz kimliği
  String imkanAdi; // İmkanın adı
  String imkanIcon; // İmkanın ikonu
}
