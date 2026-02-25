import 'package:dadosbr/core/constants/api_constants.dart';
import 'package:dadosbr/modules/domain/services/domain_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late DomainService service;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    service = DomainService(dio: mockDio);
  });
  group('DomainRepository', () {
    const domain = 'brasilapi.com.br';
    final responseData = {
      "status_code": 2,
      "status": "REGISTERED",
      "fqdn": "brasilapi.com.br",
      "hosts": ["bob.ns.cloudflare.com", "lily.ns.cloudflare.com"],
      "publication-status": "published",
      "expires-at": "2022-09-23T00:00:00-03:00",
      "suggestions": [
        "agr.br",
        "app.br",
        "art.br",
        "blog.br",
        "dev.br",
        "eco.br",
        "esp.br",
        "etc.br",
        "far.br",
        "flog.br",
        "imb.br",
        "ind.br",
        "inf.br",
        "log.br",
        "net.br",
        "ong.br",
        "rec.br",
        "seg.br",
        "srv.br",
        "tec.br",
        "tmp.br",
        "tur.br",
        "tv.br",
        "vlog.br",
        "wiki.br",
      ],
    };

    test('Deve retornar Map quando a requisição for bem sucedida', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: responseData,
          statusCode: 200,
        ),
      );

      final result = await service.getDomainInfo(domain);

      expect(result, responseData);
      verify(() => mockDio.get('${ApiConstants.domain}$domain')).called(1);
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
      expect(() => service.getDomainInfo(domain), throwsA(isA<DioException>()));
    });

    test('Deve lançar DioException quando ocorrer erro de conexão', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
        ),
      );
      expect(() => service.getDomainInfo(domain), throwsA(isA<DioException>()));
    });

    test('deve lançar DioException em timeout', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      expect(() => service.getDomainInfo(domain), throwsA(isA<DioException>()));
    });
  });
}
