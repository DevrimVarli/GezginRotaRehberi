/// Uygulamada kullanılan kategori başlıklarını sağlayan repository sınıfı
class KategoriRepo {
  /// Sabit kategori başlıklarını döndürür
  List<String> basliklar() {
    // Kategori isimleri
    List<String> baslikList = <String>[
      'Location',
      'Hotels',
      'Food',
      'Adventure',
      'Location',
      'Hotels',
      'Food',
      'Adventure',
    ];

    return baslikList;
  }
}
