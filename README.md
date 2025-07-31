# ✨ GezginRotaRehberi

**GezginRotaRehberi ile**, kullanıcılar çevredeki restoranları, otelleri keşfedebilir, favori yerlerini işaretleyebilir ve profil ayarlarını kolayca yönetebilir.

---

## 🚀 Öne Çıkan Özellikler

- **Konum Bazlı Keşif**: Kullanıcı bulunduğu lokasyona göre mekanları filtreleyebilir, *Hotels*, *Food*, *Adventure* gibi kategorilerde listelenmiş önerilere ulaşabilir.  
- **Popüler Mekanlar**: Öne çıkarılan restoran ve oteller, kullanıcı yorumları ve puanlarına göre listeleniyor.
- **Detaylı Mekan Sayfası**: Her mekan için; görsel galeri, kullanıcı oylaması, tanım ve "Book Now"/"Rezervasyon Yap" butonu mevcut.
- **Favoriler Yönetimi**: Restoran ve otelleri favorilere ekleme, listede gösterme ve hızlı erişim.
- **Kullanıcı Profili**: Kullanıcı bilgileri, profil fotoğrafı güncelleme, AdSoyad, KullanıcıAdı, e‑posta, UID ve telefon numarası görüntüleme.
- **Adres Yönetimi**:
  - Kullanıcı teslimat adreslerini ekleyebilir, düzenleyebilir ya da silebilir.
  - GPS ile mevcut konum seçme veya manuel adres girişi.
  - İl/İlçe/Mahalle/Sokak gibi alanlarda veri doğrulama.
  - Kayıtlı adres başlığını (“evim” gibi) özelleştirebilme.

---

## 📸 Uygulama Ekran Görüntüleri

<p align="center">
  <img src="assets/screenshots/loginEkran.png" width="250" alt="Login Ekranı">
  <img src="assets/screenshots/anaEkran.png" width="250" alt="Ana Ekran">
  <img src="assets/screenshots/introEkran.png" width="250" alt="Intro Ekranı">
  <img src="assets/screenshots/profilEkran.png" width="250" alt="Profil Ekranı">
</p>

<p align="center">
  **Giriş Ekranı** | **Ana Ekran** | **Intro Ekranı** | **Profil Ekranı**
</p>

<p align="center">
  <img src="assets/screenshots/favoriteEkran.png" width="250" alt="Favori Ekranı">
  <img src="assets/screenshots/haritaEkrani.png" width="250" alt="Harita Ekranı">
  <img src="assets/screenshots/detayEkran.png" width="250" alt="Detay Ekranı">
  <img src="assets/screenshots/accountInfoEkran.png" width="250" alt="Account Info Ekranı">
</p>

<p align="center">
  **Favori Ekranı** | **Harita Ekranı** | **Detay Ekranı** | **Account Info Ekranı**
</p>

<p align="center">
  <img src="assets/screenshots/adresEklemeEkrani.png" width="250" alt="Adres Ekleme Ekranı">
  <img src="assets/screenshots/adreslerimEkran.png" width="250" alt="Adreslerim Ekranı">
</p>

<p align="center">
  **Adres Ekleme Ekranı** | **Adreslerim Ekranı**
</p>

---

## 🛠️ Teknolojiler / Teknoloji Akışı

- **Platform**: Flutter & Dart
- **Mobil Tasarım**: Siyah temalı UI, modern widget yapısı, segment kontrol (Favoriler: Restoranlar / Oteller).
- **Konum Entegrasyonu**: Haritada pin ile lokasyon seçimi (OpenStreetMap veya Google Maps SDK vb).
- **Veri Depolama**: Kullanıcı profil ve favori mekanlar için Firebase Auth & Firestore ya da benzeri bir backend kullanılabilir.
- **Favoriler & Mekan Bilgileri**: JSON / API yapısıyla listelenen mekan verisi (resim, isim, puan, açıklama vs.).
- **Adres Girişi**: Form tabanlı inputlarla; adres kaydetme/düzenleme iş akışı.

---

