import 'package:dadosbr/modules/cpnj/repositories/cnpj_repository.dart';
import 'package:dadosbr/modules/cpnj/services/cnpj_service.dart';
import 'package:dadosbr/modules/cpnj/viewmodels/cnpj_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

Future<void> cnpjModule(GetIt getIt) async {
  getIt.registerLazySingleton(() => CnpjService(dio: getIt<Dio>()));
  getIt.registerLazySingleton(
    () => CnpjRepository(service: getIt<CnpjService>()),
  );
  getIt.registerFactory(
    () => CnpjViewmodel(cnpjRepository: getIt<CnpjRepository>()),
  );
}
