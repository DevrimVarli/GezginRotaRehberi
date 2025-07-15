import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/repository/IconRepo.dart';

import '../repository/RestorantRepo.dart';
import '../repository/otelRepo.dart';

final otelFutureProvider=FutureProvider((ref)async{
  return await otelRepo().oteller();
});
final restoranFutureProvider=FutureProvider((ref)async{
  return await ResetoranRepo().restorantlar();
});
final imkanRestFutureProvider=FutureProvider((ref)async{
  return await imkanRepo().imkanlar();
});
