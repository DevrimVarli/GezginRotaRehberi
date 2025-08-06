/// Uygulamada kullanılan kategori başlıklarını sağlayan repository sınıfı
class KategoriRepo {
  /// Sabit kategori başlıklarını döndürür
  List<String> basliklar() {
    // Kategori isimleri
    List<String> baslikList = <String>[
      'location',
      'hotels',
      'food',
      'adventure',
      'location',
      'hotels',
      'food',
      'adventure',
    ];

    return baslikList;
  }
}
