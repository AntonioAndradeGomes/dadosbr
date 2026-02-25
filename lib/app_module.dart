import 'package:dadosbr/modules/cep/cep_module.dart';
import 'package:dadosbr/modules/cpnj/cnpj_module.dart';
import 'package:dadosbr/modules/domain/domain_module.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> appModule() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  cepModule(getIt);
  cnpjModule(getIt);
  domainModule(getIt);
}
