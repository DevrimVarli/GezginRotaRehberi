# ✨ Explore & Discover App

**Aspen ile**, kullanıcılar çevredeki restoranları, otelleri keşfedebilir, favori yerlerini işaretleyebilir ve profil ayarlarını kolayca yönetebilir.

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

## 📱 Ekran Görüntüleri

- **Explore**: `Aspen` ana sayfası; kullanıcı konumuna göre popüler ve önerilen mekanlar listeleniyor.  
- **Mekan Detayı**: Luna Bar Restaurant gibi mekanların iç mekan görüntüleri, puanı (ör. 4.8/5), tanımı ve rezervasyon butonu.  
- **Favoriler**: Henüz favori olmadığı zaman “Favori restoran bulunamadı” mesajı; favori eklendiğinde listeleniyor (örneğin: Tola Restaurant, Zennup 1844).  
- **Profil**: Kullanıcı detayları ve profil fotoğrafı bölümü.  
- **Adres Seçimi/Düzenleme**: Haritada konum seçimi, adres alanlarının girilmesi ve adres kaydetme ekranları.

---

## 🛠️ Teknolojiler / Teknoloji Akışı

- **Platform**: Flutter & Dart
- **Mobil Tasarım**: Siyah temalı UI, modern widget yapısı, segment kontrol (Favoriler: Restoranlar / Oteller).
- **Konum Entegrasyonu**: Haritada pin ile lokasyon seçimi (OpenStreetMap veya Google Maps SDK vb).
- **Veri Depolama**: Kullanıcı profil ve favori mekanlar için Firebase Auth & Firestore ya da benzeri bir backend kullanılabilir.
- **Favoriler & Mekan Bilgileri**: JSON / API yapısıyla listelenen mekan verisi (resim, isim, puan, açıklama vs.).
- **Adres Girişi**: Form tabanlı inputlarla; adres kaydetme/düzenleme iş akışı.

---

## 📂 Proje Yapısı (Öneri)

