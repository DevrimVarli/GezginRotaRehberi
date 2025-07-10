import 'package:yeni_tasarim/model/oteller.dart';

class otelRepo{
  void  oteller(List<Oteller>otelList){

    otelList.addAll([
      Oteller(1, "Explore Aspen", "explore-aspen.png", "4N/5D","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",200),
      Oteller(2, "Luxurious Aspen", "luxurious-aspen.png", "2N/3D","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",300),
      Oteller(3, "Explore Aspen", "explore-aspen.png", "4N/5D","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",200),
      Oteller(4, "Luxurious Aspen", "luxurious-aspen.png", "2N/3D","Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",300),

    ]);


  }
}