class AdresBilgisi {
  AdresBilgisi({
    required this.sokakAdi,
    required this.mahalleAdi,
    required this.ilceAdi,
    required this.sehirAdi,
    required this.ulkeAdi,
  });

  factory AdresBilgisi.fromJson(Map<String, dynamic> json) {
    return AdresBilgisi(
      sokakAdi: json['road']?.toString() ?? '',
      mahalleAdi: json['suburb']?.toString() ?? '',
      ilceAdi: json['town']?.toString() ?? json['county']?.toString() ?? '',
      sehirAdi: json['province']?.toString() ?? json['state']?.toString() ?? '',
      ulkeAdi: json['country']?.toString() ?? '',
    );
  }

  String sokakAdi;
  String mahalleAdi;
  String ilceAdi;
  String sehirAdi;
  String ulkeAdi;
}
