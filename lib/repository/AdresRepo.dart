import '../model/Konum.dart';

class AdresRepo{
  List<Konum>konumList=[];
  List<Konum>  konumlar(){
    Konum konum1 = Konum("Bursa", "Osmangazi");
    Konum konum2 = Konum("Bursa", "Nilüfer");
    Konum konum3 = Konum("Bursa", "Mudanya");
    konumList.add(konum1);
    konumList.add(konum2);
    konumList.add(konum3);
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