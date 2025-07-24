import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/repository/adres_repo.dart';
import 'package:yeni_tasarim/repository/icon_repo.dart';
import 'package:yeni_tasarim/repository/kategori_repo.dart';
import 'package:flutter/material.dart';
import 'package:yeni_tasarim/repository/restoran_repo.dart';
import 'package:yeni_tasarim/repository/otel_repo.dart';
import 'package:yeni_tasarim/services/auth_service.dart';

final FutureProvider<List<Oteller>> otelFutureProvider = FutureProvider<List<Oteller>>((Ref ref) async {
  return otelRepo().oteller();
});

final FutureProvider<List<Restorantlar>> restoranFutureProvider=FutureProvider<List<Restorantlar>>((Ref ref)async{
  return ResetoranRepo().restorantlar();
});
final FutureProvider<List<Imkanlar>> imkanRestFutureProvider=FutureProvider<List<Imkanlar>>((Ref ref)async{
  return ImkanRepo().imkanlar();
});
final Provider<List<String>> kategoriFutureProvider=Provider<List<String>>((Ref ref){
  return  KategoriRepo().basliklar();
});
final StateProvider<Konum> secilemKonumStateProvider=StateProvider<Konum>((Ref ref)=>Konum( 'Bursa', 'Osmangazi'));
final StateProvider<List<Konum>> konumlarProvider=StateProvider<List<Konum>>((Ref ref){
  ref.keepAlive();
  return AdresRepo().konumlar();
});
final StateProvider<int> selectedIndexProvider=StateProvider<int>((Ref ref)=>0);
final StateProvider<String> aramaSonucuStateProvider=StateProvider<String>((Ref ref)=>'');
final StateProvider<bool> seeAllStateProvider=StateProvider<bool>(( Ref ref)=>false);
final StateProvider<bool> favoriteButtonStateProvider=StateProvider<bool>((Ref ref)=>false);
final StateProvider<List<String>> favoriListesiProvider=StateProvider<List<String>>((Ref ref) {
  ref.keepAlive();
  return <String>[];
});
final StateProvider<bool> kayitMiProvider=StateProvider<bool>((Ref ref)=>false);
final Provider<AuthService> authProvider = Provider(AuthService.new);
final StreamProvider<User?> userChangesProvider = StreamProvider<User?>((Ref ref) {
  return FirebaseAuth.instance.authStateChanges();
});
final Provider<List<String>> generalKategoriProvider=Provider<List<String>>((Ref ref){
  return <String>['Seyahatlerim','Kampanyalarım','Favorilerim', 'Profilim','Çıkış Yap'];
});
final Provider<List<String>> accountKategoriProvider=Provider<List<String>>((Ref ref){
  return <String>['Security Settings','Delete Account'];
});
final Provider<List<String>> otherKategoriProvider=Provider<List<String>>((Ref ref){
  return <String>['FAQ','Privacy Policy','Terms and Conditions'];
});
final StateProvider<ThemeMode> themeModeProvider = StateProvider<ThemeMode>((Ref ref) {
  return ThemeMode.system; // Başlangıç
});
final AutoDisposeProvider<TextEditingController> emailControllerProvider = Provider.autoDispose<TextEditingController>((Ref ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});


final AutoDisposeProvider<TextEditingController> passwordControllerProvider = Provider.autoDispose<TextEditingController>((Ref ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final AutoDisposeProvider<TextEditingController> newPasswordControllerProvider = Provider.autoDispose<TextEditingController>((Ref ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});


final AutoDisposeProvider<TextEditingController> firstNameControllerProvider = Provider.autoDispose<TextEditingController>((Ref ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});


final AutoDisposeProvider<TextEditingController> lastNameControllerProvider = Provider.autoDispose<TextEditingController>((Ref ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final AutoDisposeProvider<TextEditingController> phoneNumberControllerProvider = Provider.autoDispose<TextEditingController>((Ref ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final AutoDisposeProvider<TextEditingController> userNameControllerProvider = Provider.autoDispose<TextEditingController>((Ref ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final StateProvider<bool> checkBoxStateProvider=StateProvider<bool>((Ref ref)=>false);
final StateProvider<String> userPhotoProvider=StateProvider<String>((Ref ref)=>'');
