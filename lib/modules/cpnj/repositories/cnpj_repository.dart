import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/errors/dio_eception_handler.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_model.dart';
import 'package:dadosbr/modules/cpnj/services/cnpj_service.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class CnpjRepository {
  final CnpjService _cnpjService;

  CnpjRepository({required CnpjService service}) : _cnpjService = service;

  AsyncResult<CnpjModel> getCnpjInfo(String cnpj) async {
    try {
      final cnpjInfo = await _cnpjService.getCnpjInfo(cnpj);
      return Success(CnpjModel.fromJson(cnpjInfo));
    } on DioException catch (e) {
      return Failure(DioExceptionHandler.handle(e));
    } catch (e) {
      return Failure(const ServerException());
    }
  }
}
