import 'package:dadosbr/modules/cep/repositories/cep_repository.dart';
import 'package:dadosbr/modules/cep/services/cep_service.dart';
import 'package:dadosbr/modules/cep/viewmodels/cep_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

Future<void> cepModule(GetIt getIt) async {
  getIt.registerLazySingleton(() => CepService(dio: getIt<Dio>()));
  getIt.registerLazySingleton(
    () => CepRepository(service: getIt<CepService>()),
  );
  getIt.registerFactory(
    () => CepViewmodel(cepRepository: getIt<CepRepository>()),
  );
}
