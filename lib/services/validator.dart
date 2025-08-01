/// E-posta doğrulama fonksiyonu.
/// - Boş olamaz.
/// - '@' ve '.' karakterlerini içermeli.
String? mailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Boş bırakılamaz.';
  if (!value.contains('@') || !value.contains('.')) return 'Geçersiz mail.';
  return null; // Geçerli e-posta
}

/// Şifre doğrulama fonksiyonu.
/// - Boş olamaz.
/// - En az 6 karakter olmalı.
String? passValidator(String? value) {
  if (value!.length < 6) {
    return 'Şifreniz en az 6 haneli olmalıdır.';
  }
  if (value.isEmpty) {
    return 'Boş bırakılamaz.';
  }
  return null; // Geçerli şifre
}

/// İkinci şifre alanı doğrulama (örn: şifre tekrar alanı).
/// Şu anda kontrol yapılmıyor, her zaman null döner.
String? passValidator2(String? value) {
  return null;
}

/// Telefon numarası doğrulama.
/// - Boş olamaz.
/// - Sadece rakam içermeli.
/// - 11 haneli olmalı.
/// - '05' ile başlamalı.
String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Telefon numarası boş bırakılamaz.';
  }
  // Sadece rakamlardan oluşuyor mu?
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Telefon numarası sadece rakamlardan oluşmalıdır.';
  }
  if (value.length != 11) {
    return 'Telefon numarası 11 haneli olmalıdır.';
  }
  if (!value.startsWith('05')) {
    return 'Telefon numarası 05 ile başlamalıdır.';
  }
  return null; // Geçerli numara
}

/// Ad alanı doğrulama.
/// - Boş olamaz.
String? firstNameValidator(String? value) {
  if (value == null || value.isEmpty) return 'Boş bırakılamaz.';
  return null;
}

/// Soyad alanı doğrulama.
/// - Boş olamaz.
String? lastNameValidator(String? value) {
  if (value == null || value.isEmpty) return 'Boş bırakılamaz.';
  return null;
}

/// Kullanıcı adı doğrulama.
/// - Boş olamaz.
String? userNameValidator(String? value) {
  if (value == null || value.isEmpty) return 'Boş bırakılamaz.';
  return null;
}
