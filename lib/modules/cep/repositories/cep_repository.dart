import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/errors/dio_eception_handler.dart';
import 'package:dadosbr/modules/cep/models/cep_model.dart';
import 'package:dadosbr/modules/cep/services/cep_service.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class CepRepository {
  final CepService _cepService;

  CepRepository({required CepService service}) : _cepService = service;

  AsyncResult<CepModel> getCepInfo(String cep) async {
    try {
      final cepInfo = await _cepService.getCepInfo(cep);
      return Success(CepModel.fromJson(cepInfo));
    } on DioException catch (e) {
      return Failure(DioExceptionHandler.handle(e));
    } catch (e) {
      return Failure(const ServerException());
    }
  }
}
