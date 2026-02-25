import 'package:dadosbr/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class CnpjService {
  final Dio _dio;

  CnpjService({required Dio dio}) : _dio = dio;

  Future<Map<String, dynamic>> getCnpjInfo(String cnpj) async {
    final response = await _dio.get('${ApiConstants.cnpj}$cnpj');
    return response.data as Map<String, dynamic>;
  }
}
