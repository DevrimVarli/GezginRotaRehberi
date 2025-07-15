class Imkanlar {
  int imkanID;
  String imkanAdi;
  String imkan_icon;

  Imkanlar(this.imkanID, this.imkanAdi, this.imkan_icon);

  factory Imkanlar.fromJson(Map<String, dynamic> json) {
    return Imkanlar(
      json["imkan_id"] as int? ?? 0,
      json["imkan_ad"] as String? ?? 'No Name',
      json["imkan_icon"] as String? ?? 'default_icon',
    );
  }
}