String? mailValidator(String? value) {
  if (value == null || value.isEmpty) return "Boş bırakılamaz.";
  if (!value.contains("@") || !value.contains(".")) return "Geçersiz mail.";
  return null;
}
String ? passValidator(String? value){
  if(value!.length<6){
    return "Şifreniz en az 6 haneli olmalıdır.";
  }
  if(value!.isEmpty){
    return "Boş bırakılamaz.";
  }
  return null;
}String ? passValidator2(String? value){
  return null;
}
String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Telefon numarası boş bırakılamaz.";
  }
  // Sadece rakam içeriyor mu?
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return "Telefon numarası sadece rakamlardan oluşmalıdır.";
  }
  if (value.length != 11) {
    return "Telefon numarası 11 haneli olmalıdır.";
  }
  if (!value.startsWith('05')) {
    return "Telefon numarası 05 ile başlamalıdır.";
  }
  return null; // Doğruysa null dön
}

String ? firstNameValidator(String? value){
  if (value == null || value.isEmpty) return "Boş bırakılamaz.";
  return null;
}
String ? lastNameValidator(String? value){
  if (value == null || value.isEmpty) return "Boş bırakılamaz.";
  return null;
}
String ? userNameValidator(String? value){
  if (value == null || value.isEmpty) return "Boş bırakılamaz.";
  return null;
}
