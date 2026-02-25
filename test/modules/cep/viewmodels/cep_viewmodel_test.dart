import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/cep/models/cep_model.dart';
import 'package:dadosbr/modules/cep/repositories/cep_repository.dart';
import 'package:dadosbr/modules/cep/viewmodels/cep_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class CepRepositoryMock extends Mock implements CepRepository {}

void main() {
  late CepRepositoryMock repository;
  late CepViewmodel viewmodel;

  setUp(() {
    repository = CepRepositoryMock();
    viewmodel = CepViewmodel(cepRepository: repository);
  });

  tearDown(() => viewmodel.dispose());

  group('CepViewmodel', () {
    const cep = '01001000';
    const cepInfo = CepModel(
      cep: '01001-000',
      state: 'SP',
      city: 'São Paulo',
      neighborhood: 'Sé',
      street: 'Praça da Sé',
      service: 'Correios',
    );

    test('Deve retornar o estado inicial', () async {
      expect(viewmodel.value, const IdleState<CepModel>());
    });

    test('Deve emitir LoadingState e depois SuccessState', () async {
      when(
        () => repository.getCepInfo(cep),
      ).thenAnswer((_) async => const Success(cepInfo));

      final states = <ViewState<CepModel>>[];

      void listener() => states.add(viewmodel.value);
      viewmodel.addListener(listener);

      await viewmodel.fetchCepInfo(cep);

      viewmodel.removeListener(listener);

      expect(states.length, 2);
      expect(states[0], isA<LoadingState<CepModel>>());
      expect(states[1], isA<SuccessState<CepModel>>());
      expect((states.last as SuccessState<CepModel>).data, cepInfo);
      verify(() => repository.getCepInfo(cep)).called(1);
    });

    test('Deve emitir LoadingState e depois ErrorState', () async {
      when(
        () => repository.getCepInfo(cep),
      ).thenAnswer((_) async => Failure(NotFoundException()));
      await viewmodel.fetchCepInfo(cep);
      verify(() => repository.getCepInfo(cep)).called(1);
      expect(viewmodel.value, isA<ErrorState<CepModel>>());
      final errorState = viewmodel.value as ErrorState<CepModel>;
      expect(errorState.exception, isA<NotFoundException>());
    });
  });
}
