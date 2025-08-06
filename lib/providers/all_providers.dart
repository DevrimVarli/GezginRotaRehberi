import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/providers/kullanici_konumlar_notifier.dart';
import 'package:yeni_tasarim/repository/adres_repo.dart';
import 'package:yeni_tasarim/repository/icon_repo.dart';
import 'package:yeni_tasarim/repository/kategori_repo.dart';
import 'package:yeni_tasarim/repository/otel_repo.dart';
import 'package:yeni_tasarim/repository/restoran_repo.dart';
import 'package:yeni_tasarim/services/auth_service.dart';
import 'package:yeni_tasarim/services/location_service.dart';

/// Oteller listesini API’den çekmek için FutureProvider
final FutureProvider<List<Oteller>> otelFutureProvider =
    FutureProvider<List<Oteller>>((Ref ref) async {
      return OtelRepo().oteller();
    });

/// Restoran listesini API’den çekmek için FutureProvider
final FutureProvider<List<Restorantlar>> restoranFutureProvider =
    FutureProvider<List<Restorantlar>>((Ref ref) async {
      return RestoranRepo().restorantlar();
    });

/// İmkanlar listesini API’den çeken FutureProvider
final FutureProvider<List<Imkanlar>> imkanRestFutureProvider =
    FutureProvider<List<Imkanlar>>((Ref ref) async {
      return ImkanRepo().imkanlar();
    });

/// Kategori başlıklarını sağlayan Provider
final Provider<List<String>> kategoriFutureProvider = Provider<List<String>>((
  Ref ref,
) {
  return KategoriRepo().basliklar();
});

/// Seçili konumu tutan StateProvider (başlangıç: Bursa / Osmangazi)
final StateProvider<Konum> secilemKonumStateProvider = StateProvider<Konum>(
  (Ref ref) => Konum('Bursa', 'Osmangazi'),
);

/// Tüm konumları sağlayan StateProvider
final StateProvider<List<Konum>> konumlarProvider = StateProvider<List<Konum>>((
  Ref ref,
) {
  ref.keepAlive();
  return AdresRepo().konumlar();
});

/// Kullanıcı konumlarını yöneten StateNotifierProvider
final StateNotifierProvider<
  KullaniciKonumlarNotifier,
  List<KullaniciKonumFreezed>
>
kullaniciKonumlarProvider = StateNotifierProvider<
  KullaniciKonumlarNotifier,
  List<KullaniciKonumFreezed>
>((Ref ref) => KullaniciKonumlarNotifier());

/// Ana sayfa alt menü seçili index
final StateProvider<int> selectedIndexProvider = StateProvider<int>(
  (Ref ref) => 0,
);

/// Arama sonuç metnini tutar
final StateProvider<String> aramaSonucuStateProvider = StateProvider<String>(
  (Ref ref) => '',
);

/// “See All” butonu açık mı kapalı mı?
final StateProvider<bool> seeAllStateProvider = StateProvider<bool>(
  (Ref ref) => false,
);

/// Favori butonu durumu
final StateProvider<bool> favoriteButtonStateProvider = StateProvider<bool>(
  (Ref ref) => false,
);

/// Kayıt olma ekranında mıyız kontrolü
final StateProvider<bool> kayitMiProvider = StateProvider<bool>(
  (Ref ref) => false,
);

/// AuthService instance’ı
final Provider<AuthService> authProvider = Provider<AuthService>(
  AuthService.new,
);

/// LocationService instance’ı
final Provider<LocationService> locationProvider = Provider<LocationService>((
  Ref ref,
) {
  return LocationService();
});

/// Firebase kullanıcı oturum değişikliklerini dinleyen StreamProvider
final StreamProvider<User?> userChangesProvider = StreamProvider<User?>((
  Ref ref,
) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Profil ekranı menü kategorileri
final Provider<List<String>> generalKategoriProvider = Provider<List<String>>((
  Ref ref,
) {
  return <String>[
    'my_trips',
    'my_campaigns',
    'my_favorites',
    'my_profile',
    'logout',
  ];
});

/// Hesap ayarları menüsü
final Provider<List<String>> accountKategoriProvider = Provider<List<String>>((
  Ref ref,
) {
  return <String>['security_settings', 'delete_account'];
});

/// Diğer bilgiler menüsü
final Provider<List<String>> otherKategoriProvider = Provider<List<String>>((
  Ref ref,
) {
  return <String>['faq', 'privacy_policy', 'terms_and_conditions'];
});

/// Tema modu (light/dark)
final StateProvider<ThemeMode> themeModeProvider = StateProvider<ThemeMode>((
  Ref ref,
) {
  return ThemeMode.light;
});

/// E-mail input controller (autoDispose)
final AutoDisposeProvider<TextEditingController> emailControllerProvider =
    Provider.autoDispose<TextEditingController>((Ref ref) {
      TextEditingController controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

/// Şifre input controller
final AutoDisposeProvider<TextEditingController> passwordControllerProvider =
    Provider.autoDispose<TextEditingController>((Ref ref) {
      TextEditingController controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

/// Yeni şifre input controller
final AutoDisposeProvider<TextEditingController> newPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>((Ref ref) {
      TextEditingController controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

/// İsim input controller
final AutoDisposeProvider<TextEditingController> firstNameControllerProvider =
    Provider.autoDispose<TextEditingController>((Ref ref) {
      TextEditingController controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

/// Soyisim input controller
final AutoDisposeProvider<TextEditingController> lastNameControllerProvider =
    Provider.autoDispose<TextEditingController>((Ref ref) {
      TextEditingController controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

/// Telefon numarası input controller
final AutoDisposeProvider<TextEditingController> phoneNumberControllerProvider =
    Provider.autoDispose<TextEditingController>((Ref ref) {
      TextEditingController controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

/// Kullanıcı adı input controller
final AutoDisposeProvider<TextEditingController> userNameControllerProvider =
    Provider.autoDispose<TextEditingController>((Ref ref) {
      TextEditingController controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

/// CheckBox durumu (ör. sözleşme onayı)
final StateProvider<bool> checkBoxStateProvider = StateProvider<bool>(
  (Ref ref) => false,
);

/// Kullanıcı profil fotoğrafı URL’si
final StateProvider<String> userPhotoProvider = StateProvider<String>(
  (Ref ref) => '',
);

/// Başlangıç harita konumu (İstanbul koordinatları)
final StateProvider<LatLng> baslangicKonumuProvider = StateProvider<LatLng>(
  (Ref ref) => const LatLng(41.015137, 28.979530),
);

/// Seçilen harita konumu
final StateProvider<LatLng> secilenKonumuProviderLatLng = StateProvider<LatLng>(
  (Ref ref) => const LatLng(41.015137, 28.979530),
);

/// Favoriler Hive Box provider
final StateProvider<Box<String>> favorilerProvider = StateProvider<Box<String>>(
  (Ref ref) {
    return Hive.box<String>('favoriler');
  },
);
