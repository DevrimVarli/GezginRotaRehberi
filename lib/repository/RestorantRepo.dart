import 'package:yeni_tasarim/model/Restorantlar.dart';

class RestorantRepo{
  void  restorantlar(List<Restorantlar>restorantlarList){
    restorantlarList.addAll([ Restorantlar(1, "Alley Palace", "alley-palace.png", "4.1"),
      Restorantlar(2, "Coeurdes Alpes", "coeurdes-alpes.png", "4.5"),
      Restorantlar(3, "Alley Palace", "alley-palace.png", "4.1"),
      Restorantlar(4, "Coeurdes Alpes", "coeurdes-alpes.png", "4.5"),
    ]);


  }
}