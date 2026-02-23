import 'package:dadosbr/modules/cep/cep_module.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> appModule() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  cepModule(getIt);
}
