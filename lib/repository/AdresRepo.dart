import '../model/Konum.dart';

class AdresRepo{
  List<Konum>  konumlar(){
    List<Konum>konumList=[];
    Konum konum1 = Konum(1, "Ankara", "Çankaya");
    Konum konum2 = Konum(2, "Ankara", "Yenimahalle");
    Konum konum3 = Konum(3, "Ankara", "Keçiören");
    Konum konum4 = Konum(4, "Ankara", "Çatalca");
    Konum konum5 = Konum(4, "Ankara", "Ulus");
    konumList.add(konum1);
    konumList.add(konum2);
    konumList.add(konum3);
    konumList.add(konum4);
    konumList.add(konum5);
    return konumList;
  }
}