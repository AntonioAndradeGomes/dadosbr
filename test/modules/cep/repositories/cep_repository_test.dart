import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/modules/cep/repositories/cep_repository.dart';
import 'package:dadosbr/modules/cep/services/cep_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCepService extends Mock implements CepService {}

void main() {
  late CepRepository repository;
  late MockCepService mockService;

  setUp(() {
    mockService = MockCepService();
    repository = CepRepository(service: mockService);
  });

  group('CepRepository.getCepInfo', () {
    const cep = '01001000';
    final responseData = {
      "cep": "01001-000",
      'state': 'SP',
      'city': 'São Paulo',
      'neighborhood': 'Sé',
      'street': 'Praça da Sé',
    };

    test(
      'Deve retornar Success com o CepModel quando o serviço funcionar',
      () async {
        when(
          () => mockService.getCepInfo(cep),
        ).thenAnswer((_) async => responseData);

        final result = await repository.getCepInfo(cep);
        expect(result.isSuccess(), true);

        final model = result.getOrNull();
        expect(model, isNotNull);
        expect(model!.cep, '01001-000');
        expect(model.state, 'SP');
        expect(model.city, 'São Paulo');
        expect(model.neighborhood, 'Sé');
        expect(model.street, 'Praça da Sé');
        expect(model.service, null);
        verify(() => mockService.getCepInfo(cep)).called(1);
      },
    );

    test('Deve retornar Failure com NotFoundException quando 404', () async {
      when(() => mockService.getCepInfo(cep)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.getCepInfo(cep);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<NotFoundException>());
      verify(() => mockService.getCepInfo(cep)).called(1);
    });

    test('Deve retornar Failure com ValidationException quando 400', () async {
      when(() => mockService.getCepInfo(cep)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await repository.getCepInfo(cep);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<ValidationException>());
      verify(() => mockService.getCepInfo(cep)).called(1);
    });

    test('Deve retornar Failure com ServerException quando 500', () async {
      when(() => mockService.getCepInfo(cep)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await repository.getCepInfo(cep);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<ServerException>());
      verify(() => mockService.getCepInfo(cep)).called(1);
    });

    test(
      'Deve retornar Failure com TimeoutException em receiveTimeout',
      () async {
        when(() => mockService.getCepInfo(cep)).thenThrow(
          DioException(
            type: DioExceptionType.receiveTimeout,
            response: Response(requestOptions: RequestOptions(path: '')),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        final result = await repository.getCepInfo(cep);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<TimeoutException>());
        verify(() => mockService.getCepInfo(cep)).called(1);
      },
    );

    test(
      'Deve retornar Failure com NetworkException em connectionError',
      () async {
        when(() => mockService.getCepInfo(cep)).thenThrow(
          DioException(
            type: DioExceptionType.connectionError,
            response: Response(requestOptions: RequestOptions(path: '')),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        final result = await repository.getCepInfo(cep);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<NetworkException>());
        verify(() => mockService.getCepInfo(cep)).called(1);
      },
    );

    test(
      'Deve retornar Failure com ServerException em erro inesperado',
      () async {
        when(
          () => mockService.getCepInfo(cep),
        ).thenThrow(Exception('Erro inesperado'));

        final result = await repository.getCepInfo(cep);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<ServerException>());
        verify(() => mockService.getCepInfo(cep)).called(1);
      },
    );
  });
}
