import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/modules/cpnj/repositories/cnpj_repository.dart';
import 'package:dadosbr/modules/cpnj/services/cnpj_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCnpjService extends Mock implements CnpjService {}

void main() {
  late CnpjRepository repository;
  late MockCnpjService mockService;

  setUp(() {
    mockService = MockCnpjService();
    repository = CnpjRepository(service: mockService);
  });

  group('CnpjRepository.getCnpjInfo', () {
    const cnpj = '19131243000197';
    final responseData = {
      "uf": "SP",
      "cep": "01311902",
      "qsa": [
        {
          "pais": null,
          "nome_socio": "HAYDEE SVAB",
          "codigo_pais": null,
          "faixa_etaria": "Entre 41 a 50 anos",
          "cnpj_cpf_do_socio": "***112108**",
          "qualificacao_socio": "Presidente",
          "codigo_faixa_etaria": 5,
          "data_entrada_sociedade": "2024-02-27",
          "identificador_de_socio": 2,
          "cpf_representante_legal": "***000000**",
          "nome_representante_legal": "",
          "codigo_qualificacao_socio": 16,
          "qualificacao_representante_legal": "Não informada",
          "codigo_qualificacao_representante_legal": 0,
        },
      ],
      "cnpj": "19131243000197",
      "pais": null,
      "email": null,
      "porte": "DEMAIS",
      "bairro": "BELA VISTA",
      "numero": "37",
      "ddd_fax": "",
      "municipio": "SAO PAULO",
      "logradouro": "PAULISTA 37",
      "cnae_fiscal": 9430800,
      "codigo_pais": null,
      "complemento": "ANDAR 4",
      "codigo_porte": 5,
      "razao_social": "OPEN KNOWLEDGE BRASIL",
      "nome_fantasia": "REDE PELO CONHECIMENTO LIVRE",
      "capital_social": 0,
      "ddd_telefone_1": "1123851939",
      "ddd_telefone_2": "",
      "opcao_pelo_mei": null,
      "descricao_porte": "",
      "codigo_municipio": 7107,
      "cnaes_secundarios": [
        {
          "codigo": 9493600,
          "descricao":
              "Atividades de organizações associativas ligadas à cultura e à arte",
        },
        {
          "codigo": 9499500,
          "descricao":
              "Atividades associativas não especificadas anteriormente",
        },
        {
          "codigo": 8599699,
          "descricao":
              "Outras atividades de ensino não especificadas anteriormente",
        },
        {
          "codigo": 8230001,
          "descricao":
              "Serviços de organização de feiras, congressos, exposições e festas",
        },
        {
          "codigo": 6204000,
          "descricao": "Consultoria em tecnologia da informação",
        },
      ],
      "natureza_juridica": "Associação Privada",
      "regime_tributario": [
        {
          "ano": 2017,
          "cnpj_da_scp": null,
          "forma_de_tributacao": "ISENTA DO IRPJ",
          "quantidade_de_escrituracoes": 1,
        },
        {
          "ano": 2018,
          "cnpj_da_scp": null,
          "forma_de_tributacao": "ISENTA DO IRPJ",
          "quantidade_de_escrituracoes": 1,
        },
        {
          "ano": 2019,
          "cnpj_da_scp": null,
          "forma_de_tributacao": "ISENTA DO IRPJ",
          "quantidade_de_escrituracoes": 1,
        },
        {
          "ano": 2020,
          "cnpj_da_scp": null,
          "forma_de_tributacao": "ISENTA DO IRPJ",
          "quantidade_de_escrituracoes": 1,
        },
        {
          "ano": 2021,
          "cnpj_da_scp": null,
          "forma_de_tributacao": "ISENTA DO IRPJ",
          "quantidade_de_escrituracoes": 1,
        },
        {
          "ano": 2022,
          "cnpj_da_scp": null,
          "forma_de_tributacao": "ISENTA DO IRPJ",
          "quantidade_de_escrituracoes": 1,
        },
        {
          "ano": 2023,
          "cnpj_da_scp": null,
          "forma_de_tributacao": "ISENTA DO IRPJ",
          "quantidade_de_escrituracoes": 1,
        },
      ],
      "situacao_especial": "",
      "opcao_pelo_simples": null,
      "situacao_cadastral": 2,
      "data_opcao_pelo_mei": null,
      "data_exclusao_do_mei": null,
      "cnae_fiscal_descricao":
          "Atividades de associações de defesa de direitos sociais",
      "codigo_municipio_ibge": 3550308,
      "data_inicio_atividade": "2013-10-03",
      "data_situacao_especial": null,
      "data_opcao_pelo_simples": null,
      "data_situacao_cadastral": "2013-10-03",
      "nome_cidade_no_exterior": "",
      "codigo_natureza_juridica": 3999,
      "data_exclusao_do_simples": null,
      "motivo_situacao_cadastral": 0,
      "ente_federativo_responsavel": "",
      "identificador_matriz_filial": 1,
      "qualificacao_do_responsavel": 16,
      "descricao_situacao_cadastral": "ATIVA",
      "descricao_tipo_de_logradouro": "AVENIDA",
      "descricao_motivo_situacao_cadastral": "SEM MOTIVO",
      "descricao_identificador_matriz_filial": "MATRIZ",
    };

    test(
      'Deve retornar Success com o CNPJModel quando o serviço funcionar',
      () async {
        when(
          () => mockService.getCnpjInfo(cnpj),
        ).thenAnswer((_) async => responseData);

        final result = await repository.getCnpjInfo(cnpj);
        expect(result.isSuccess(), true);

        final model = result.getOrNull();
        expect(model, isNotNull);
        verify(() => mockService.getCnpjInfo(cnpj)).called(1);
      },
    );

    test('Deve retornar Failure com NotFoundException quando 404', () async {
      when(() => mockService.getCnpjInfo(cnpj)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.getCnpjInfo(cnpj);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<NotFoundException>());
      verify(() => mockService.getCnpjInfo(cnpj)).called(1);
    });

    test('Deve retornar Failure com ValidationException quando 400', () async {
      when(() => mockService.getCnpjInfo(cnpj)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await repository.getCnpjInfo(cnpj);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<ValidationException>());
      verify(() => mockService.getCnpjInfo(cnpj)).called(1);
    });

    test('Deve retornar Failure com ServerException quando 500', () async {
      when(() => mockService.getCnpjInfo(cnpj)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await repository.getCnpjInfo(cnpj);
      expect(result.isError(), true);
      final error = result.exceptionOrNull();
      expect(error, isA<ServerException>());
      verify(() => mockService.getCnpjInfo(cnpj)).called(1);
    });

    test(
      'Deve retornar Failure com TimeoutException em receiveTimeout',
      () async {
        when(() => mockService.getCnpjInfo(cnpj)).thenThrow(
          DioException(
            type: DioExceptionType.receiveTimeout,
            response: Response(requestOptions: RequestOptions(path: '')),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        final result = await repository.getCnpjInfo(cnpj);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<TimeoutException>());
        verify(() => mockService.getCnpjInfo(cnpj)).called(1);
      },
    );

    test(
      'Deve retornar Failure com NetworkException em connectionError',
      () async {
        when(() => mockService.getCnpjInfo(cnpj)).thenThrow(
          DioException(
            type: DioExceptionType.connectionError,
            response: Response(requestOptions: RequestOptions(path: '')),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        final result = await repository.getCnpjInfo(cnpj);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<NetworkException>());
        verify(() => mockService.getCnpjInfo(cnpj)).called(1);
      },
    );

    test(
      'Deve retornar Failure com ServerException em erro inesperado',
      () async {
        when(
          () => mockService.getCnpjInfo(cnpj),
        ).thenThrow(Exception('Erro inesperado'));

        final result = await repository.getCnpjInfo(cnpj);
        expect(result.isError(), true);
        final error = result.exceptionOrNull();
        expect(error, isA<ServerException>());
        verify(() => mockService.getCnpjInfo(cnpj)).called(1);
      },
    );
  });
}
