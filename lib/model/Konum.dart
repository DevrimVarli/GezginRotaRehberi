class Konum{
  String sehir_adi;
  String ilce_adi;

  Konum(this.sehir_adi, this.ilce_adi);

  factory Konum.fromJson(Map<String, dynamic> json) {
    return Konum(
      json['il'],
      json['ilce'],
    );
  }
}