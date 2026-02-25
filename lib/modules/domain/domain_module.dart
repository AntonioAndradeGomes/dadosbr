import 'package:dadosbr/modules/domain/repositories/domain_repository.dart';
import 'package:dadosbr/modules/domain/services/domain_service.dart';
import 'package:dadosbr/modules/domain/viewmodel/domain_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

Future<void> domainModule(GetIt getIt) async {
  getIt.registerLazySingleton(() => DomainService(dio: getIt<Dio>()));
  getIt.registerLazySingleton(
    () => DomainRepository(service: getIt<DomainService>()),
  );
  getIt.registerFactory(
    () => DomainViewmodel(domainRepository: getIt<DomainRepository>()),
  );
}
