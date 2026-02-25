import 'package:dadosbr/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class DomainService {
  final Dio _dio;

  DomainService({required Dio dio}) : _dio = dio;

  Future<Map<String, dynamic>> getDomainInfo(String domain) async {
    final response = await _dio.get('${ApiConstants.domain}$domain');
    return response.data as Map<String, dynamic>;
  }
}
