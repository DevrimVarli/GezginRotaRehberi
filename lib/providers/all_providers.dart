import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/repository/AdresRepo.dart';
import 'package:yeni_tasarim/repository/IconRepo.dart';
import 'package:yeni_tasarim/repository/KategoriRepo.dart';

import '../repository/RestorantRepo.dart';
import '../repository/otelRepo.dart';
import '../services/auth_service.dart';

final otelFutureProvider=FutureProvider((ref)async{
  return await otelRepo().oteller();
});
final restoranFutureProvider=FutureProvider((ref)async{
  return await ResetoranRepo().restorantlar();
});
final imkanRestFutureProvider=FutureProvider((ref)async{
  return await imkanRepo().imkanlar();
});
final kategoriFutureProvider=Provider<List<String>>((ref){
  return  KategoriRepo().basliklar();
});
final secilemKonumStateProvider=StateProvider<Konum>((ref)=>Konum( "Bursa", "Osmangazi"));
final konumlarProvider=StateProvider<List<Konum>>((ref){
  ref.keepAlive();
  return AdresRepo().konumlar();
});
final selectedIndexProvider=StateProvider<int>((ref)=>0);
final aramaSonucuStateProvider=StateProvider<String>((ref)=>"");
final seeAllStateProvider=StateProvider<bool>((ref)=>false);
final favoriteButtonStateProvider=StateProvider<bool>((ref)=>false);
final favoriListesiProvider=StateProvider<List<String>>((ref) {
  ref.keepAlive();
  return [];
});
final kayitMiProvider=StateProvider<bool>((ref)=>false);
final authProvider = Provider((ref) => AuthService(ref));
