import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/cpnj/models/cnae_model.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_address_model.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_model.dart';
import 'package:dadosbr/modules/cpnj/repositories/cnpj_repository.dart';
import 'package:dadosbr/modules/cpnj/viewmodels/cnpj_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class CnpjRepositoryMock extends Mock implements CnpjRepository {}

void main() {
  late CnpjRepositoryMock repository;
  late CnpjViewmodel viewmodel;

  setUp(() {
    repository = CnpjRepositoryMock();
    viewmodel = CnpjViewmodel(cnpjRepository: repository);
  });

  tearDown(() => viewmodel.dispose());

  group("CnpjViewmodel", () {
    const cnpj = '19131243000197';
    final cnpjInfo = CnpjModel(
      cnpj: '19131243000197',
      razaoSocial: 'OPEN KNOWLEDGE BRASIL',
      nomeFantasia: 'REDE PELO CONHECIMENTO LIVRE',
      capitalSocial: 50000,
      naturezaJuridica: "Sociedade Empresária Limitada",
      cnae: const CnaeModel(codigo: 000000, descricao: "teste"),
      cnaesSecundarios: const [
        CnaeModel(codigo: 12112, descricao: 'descricao'),
      ],
      endereco: const CnpjAddressModel(),
    );

    test('Deve retornar o estado inicial', () async {
      expect(viewmodel.value, const IdleState<CnpjModel>());
    });

    test('Deve emitir LoadingState e depois SuccessState', () async {
      when(
        () => repository.getCnpjInfo(cnpj),
      ).thenAnswer((_) async => Success(cnpjInfo));

      final states = <ViewState<CnpjModel>>[];

      void listener() => states.add(viewmodel.value);
      viewmodel.addListener(listener);

      await viewmodel.fetchCnpjInfo(cnpj);

      viewmodel.removeListener(listener);

      expect(states.length, 2);
      expect(states[0], isA<LoadingState<CnpjModel>>());
      expect(states[1], isA<SuccessState<CnpjModel>>());
      expect((states.last as SuccessState<CnpjModel>).data, cnpjInfo);
      verify(() => repository.getCnpjInfo(cnpj)).called(1);
    });

    test('Deve emitir LoadingState e depois ErrorState', () async {
      when(
        () => repository.getCnpjInfo(cnpj),
      ).thenAnswer((_) async => Failure(NotFoundException()));
      await viewmodel.fetchCnpjInfo(cnpj);
      verify(() => repository.getCnpjInfo(cnpj)).called(1);
      expect(viewmodel.value, isA<ErrorState<CnpjModel>>());
      final errorState = viewmodel.value as ErrorState<CnpjModel>;
      expect(errorState.exception, isA<NotFoundException>());
    });
  });
}
