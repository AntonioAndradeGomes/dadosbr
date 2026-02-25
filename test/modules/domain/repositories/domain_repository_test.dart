import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/modules/domain/repositories/domain_repository.dart';
import 'package:dadosbr/modules/domain/services/domain_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDomainService extends Mock implements DomainService {}

void main() {
  late DomainRepository repository;
  late MockDomainService mockService;

  setUp(() {
    mockService = MockDomainService();
    repository = DomainRepository(service: mockService);
  });

  group('DomainRepository', () {
    const domain = 'brasilapi.com.br';
    final domainInfo = {
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
      ],
    };
    test(
      'Deve retornar os dados do domínio quando a requisição for bem sucedida',
      () async {
        when(
          () => mockService.getDomainInfo(any()),
        ).thenAnswer((_) async => domainInfo);

        final result = await repository.getDomainInfo(domain);

        expect(result.isSuccess(), true);
        final model = result.getOrNull();
        expect(model, isNotNull);
        verify(() => mockService.getDomainInfo(domain)).called(1);
      },
    );
    test('Deve retornar Failure com NotFoundException quando 404', () async {
      when(() => mockService.getDomainInfo(domain)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.getDomainInfo(domain);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<NotFoundException>());
      verify(() => mockService.getDomainInfo(domain)).called(1);
    });

    test('Deve retornar Failure com ValidationException quando 400', () async {
      when(() => mockService.getDomainInfo(domain)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await repository.getDomainInfo(domain);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<ValidationException>());
      verify(() => mockService.getDomainInfo(domain)).called(1);
    });

    test('Deve retornar Failure com ServerException quando 500', () async {
      when(() => mockService.getDomainInfo(domain)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await repository.getDomainInfo(domain);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<ServerException>());
      verify(() => mockService.getDomainInfo(domain)).called(1);
    });

    test(
      'Deve retornar Failure com TimeoutException em receiveTimeout',
      () async {
        when(() => mockService.getDomainInfo(domain)).thenThrow(
          DioException(
            type: DioExceptionType.receiveTimeout,
            response: Response(requestOptions: RequestOptions(path: '')),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        final result = await repository.getDomainInfo(domain);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<TimeoutException>());
        verify(() => mockService.getDomainInfo(domain)).called(1);
      },
    );

    test(
      'Deve retornar Failure com NetworkException em connectionError',
      () async {
        when(() => mockService.getDomainInfo(domain)).thenThrow(
          DioException(
            type: DioExceptionType.connectionError,
            response: Response(requestOptions: RequestOptions(path: '')),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        final result = await repository.getDomainInfo(domain);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<NetworkException>());
        verify(() => mockService.getDomainInfo(domain)).called(1);
      },
    );

    test(
      'Deve retornar Failure com ServerException em erro inesperado',
      () async {
        when(
          () => mockService.getDomainInfo(domain),
        ).thenThrow(Exception('Erro inesperado'));

        final result = await repository.getDomainInfo(domain);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<ServerException>());
        verify(() => mockService.getDomainInfo(domain)).called(1);
      },
    );
  });
}
