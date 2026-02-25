import 'package:dadosbr/core/constants/api_constants.dart';
import 'package:dadosbr/modules/cep/services/cep_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CepService service;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    service = CepService(dio: mockDio);
  });

  group('CepService.getCepInfo', () {
    const cep = '01001000';
    final responseData = {
      "cep": "01001-000",
      'state': 'SP',
      'city': 'São Paulo',
      'neighborhood': 'Sé',
      'street': 'Praça da Sé',
    };
    test('Deve retornar Map quando a requisição for bem sucedida', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: responseData,
          statusCode: 200,
        ),
      );

      final result = await service.getCepInfo(cep);

      expect(result, responseData);
      verify(() => mockDio.get('${ApiConstants.cep}$cep')).called(1);
    });

    test('Deve lançar DioException quando retornar 404', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          type: DioExceptionType.badResponse,
        ),
      );
      expect(() => service.getCepInfo(cep), throwsA(isA<DioException>()));
    });

    test('Deve lançar DioException quando ocorrer erro de conexão', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
        ),
      );
      expect(() => service.getCepInfo(cep), throwsA(isA<DioException>()));
    });

    test('deve lançar DioException em timeout', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      expect(() => service.getCepInfo(cep), throwsA(isA<DioException>()));
    });
  });
}
