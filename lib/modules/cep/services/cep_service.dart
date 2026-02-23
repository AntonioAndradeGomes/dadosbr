import 'package:dadosbr/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class CepService {
  final Dio _dio;

  CepService({required Dio dio}) : _dio = dio;

  Future<Map<String, dynamic>> getCepInfo(String cep) async {
    final response = await _dio.get('${ApiConstants.cep}$cep');
    return response.data as Map<String, dynamic>;
  }
}
