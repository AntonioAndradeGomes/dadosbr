import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/errors/dio_eception_handler.dart';
import 'package:dadosbr/modules/domain/models/domain_model.dart';
import 'package:dadosbr/modules/domain/services/domain_service.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class DomainRepository {
  final DomainService _domainService;

  DomainRepository({required DomainService service}) : _domainService = service;

  AsyncResult<DomainModel> getDomainInfo(String domain) async {
    try {
      final domainInfo = await _domainService.getDomainInfo(domain);
      return Success(DomainModel.fromJson(domainInfo));
    } on DioException catch (e) {
      return Failure(DioExceptionHandler.handle(e));
    } catch (e) {
      return Failure(const ServerException());
    }
  }
}
