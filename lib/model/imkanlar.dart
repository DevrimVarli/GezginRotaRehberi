class Imkanlar {
  Imkanlar(this.imkanID, this.imkanAdi, this.imkanIcon);

  factory Imkanlar.fromJson(Map<String, Object?> json) {
    return Imkanlar(
      // JSON'dan gelen değerleri doğru türlere dönüştürmek için daha güvenli kontrol yapıyoruz.
      json['imkan_id'] is int ? json['imkan_id']! as int : 0,
      json['imkan_ad'] is String ? json['imkan_ad']! as String : 'No Name',
      json['imkan_icon'] is String ? json['imkan_icon']! as String : 'default_icon',
    );
  }

  int imkanID;
  String imkanAdi;
  String imkanIcon;
}
