import 'package:yeni_tasarim/model/oteller.dart';

class otelRepo{
  void  oteller(List<Oteller>otelList){

    otelList.addAll([
      Oteller(1, "Explore Aspen", "explore-aspen.png", "4N/5D"),
      Oteller(2, "Luxurious Aspen", "luxurious-aspen.png", "2N/3D"),
      Oteller(3, "Explore Aspen", "explore-aspen.png", "4N/5D"),
      Oteller(4, "Luxurious Aspen", "luxurious-aspen.png", "2N/3D"),

    ]);


  }
}