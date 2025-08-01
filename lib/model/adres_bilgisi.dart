class AdresBilgisi {
  // Constructor: AdresBilgisi sınıfının bir örneğini oluşturmak için kullanılan parametreler
  AdresBilgisi({
    required this.sokakAdi,
    required this.mahalleAdi,
    required this.ilceAdi,
    required this.sehirAdi,
    required this.ulkeAdi,
  });

  // JSON verisinden AdresBilgisi nesnesi oluşturulması için factory metodu
  factory AdresBilgisi.fromJson(Map<String, dynamic> json) {
    return AdresBilgisi(
      sokakAdi: json['road']?.toString() ?? '', // Sokak adı verisi JSON'dan alınır
      mahalleAdi: json['suburb']?.toString() ?? '', // Mahalle adı verisi JSON'dan alınır
      ilceAdi: json['town']?.toString() ?? json['county']?.toString() ?? '', // İlçe adı verisi JSON'dan alınır
      sehirAdi: json['province']?.toString() ?? json['state']?.toString() ?? '', // Şehir adı verisi JSON'dan alınır
      ulkeAdi: json['country']?.toString() ?? '', // Ülke adı verisi JSON'dan alınır
    );
  }

  // Adresin her bileşeni için string özellikler
  String sokakAdi;
  String mahalleAdi;
  String ilceAdi;
  String sehirAdi;
  String ulkeAdi;
}
