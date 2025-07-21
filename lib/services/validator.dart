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
