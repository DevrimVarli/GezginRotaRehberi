import 'package:yeni_tasarim/model/adres_bilgisi.dart';

class AdresYaniti {

  // Constructor: AdresYaniti sınıfının bir örneğini oluşturmak için kullanılan parametreler
  AdresYaniti({required this.adres, required this.displayName});

  // Adres bilgisi (AdresBilgisi nesnesi)
  final AdresBilgisi adres;

  // Kullanıcıya ait ad (örneğin, adresin sahibi veya tanımlayıcısı)
  final String displayName;
}
