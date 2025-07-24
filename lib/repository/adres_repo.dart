import 'package:yeni_tasarim/model/Konum.dart';

class AdresRepo{
  List<Konum>konumList=<Konum>[];
  List<Konum>  konumlar(){
    Konum konum1 = Konum('Bursa', 'Osmangazi');
    Konum konum2 = Konum('Bursa', 'Nilüfer');
    Konum konum3 = Konum('Bursa', 'Mudanya');
    konumList..add(konum1)
    ..add(konum2)
    ..add(konum3);
    return konumList;
  }
  List<Konum> konumEkle(Konum konum){
    konumList.add(konum);
    return konumList;
  }
  List<Konum> konumSil(Konum konum){
    konumList.remove(konum);
    return konumList;
  }
}