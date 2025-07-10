import 'package:yeni_tasarim/model/Restorantlar.dart';

class RestorantRepo{
  void  restorantlar(List<Restorantlar>restorantlarList){
    restorantlarList.addAll([ Restorantlar(1, "Alley Palace", "alley-palace.png", "4.1","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",199),
      Restorantlar(2, "Coeurdes Alpes", "coeurdes-alpes.png", "4.5","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",399),
      Restorantlar(3, "Alley Palace", "alley-palace.png", "4.1","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",199),
      Restorantlar(4, "Coeurdes Alpes", "coeurdes-alpes.png", "4.5","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",399),
    ]);


  }
}