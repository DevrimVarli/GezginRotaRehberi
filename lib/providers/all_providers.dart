import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/repository/adres_repo.dart';
import 'package:yeni_tasarim/repository/icon_repo.dart';
import 'package:yeni_tasarim/repository/kategori_repo.dart';
import 'package:flutter/material.dart';
import '../repository/restoran_repo.dart';
import '../repository/otel_repo.dart';
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
final userChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
final generalKategoriProvider=Provider<List<String>>((ref){
  return ["Seyahatlerim","Kampanyalarım","Favorilerim", "Profilim","Çıkış Yap"];
});
final accountKategoriProvider=Provider<List<String>>((ref){
  return ["Security Settings","Delete Account"];
});
final otherKategoriProvider=Provider<List<String>>((ref){
  return ["FAQ","Privacy Policy","Terms and Conditions"];
});
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system; // Başlangıç
});
final emailControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});


final passwordControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final newPasswordControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});


final firstNameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});


final lastNameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final phoneNumberControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final userNameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final checkBoxStateProvider=StateProvider<bool>((ref)=>false);