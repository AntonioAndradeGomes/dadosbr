import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/domain/models/domain_model.dart';
import 'package:dadosbr/modules/domain/repositories/domain_repository.dart';
import 'package:dadosbr/modules/domain/viewmodel/domain_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class MockDomainRepository extends Mock implements DomainRepository {}

void main() {
  late MockDomainRepository mockRepository;
  late DomainViewmodel viewmodel;

  setUp(() {
    mockRepository = MockDomainRepository();
    viewmodel = DomainViewmodel(domainRepository: mockRepository);
  });

  group('DomainViewmodel', () {
    const domain = 'brasilapi.com.br';
    const domainJson = {
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
    final domainModel = DomainModel.fromJson(domainJson);
    test('Deve retornar o estado inicial', () {
      expect(viewmodel.value, const IdleState<DomainModel>());
    });
    test('Deve emitir LoadingState e depois SuccessState', () async {
      when(
        () => mockRepository.getDomainInfo(domain),
      ).thenAnswer((_) async => Success(domainModel));

      final states = <ViewState<DomainModel>>[];

      void listener() => states.add(viewmodel.value);
      viewmodel.addListener(listener);

      await viewmodel.fetchDomainInfo(domain);

      viewmodel.removeListener(listener);

      expect(states.length, 2);
      expect(states[0], isA<LoadingState<DomainModel>>());
      expect(states[1], isA<SuccessState<DomainModel>>());
      expect((states.last as SuccessState<DomainModel>).data, domainModel);
      verify(() => mockRepository.getDomainInfo(domain)).called(1);
    });

    test('Deve emitir LoadingState e depois ErrorState', () async {
      when(
        () => mockRepository.getDomainInfo(domain),
      ).thenAnswer((_) async => Failure(NotFoundException()));
      await viewmodel.fetchDomainInfo(domain);
      verify(() => mockRepository.getDomainInfo(domain)).called(1);
      expect(viewmodel.value, isA<ErrorState<DomainModel>>());
      final errorState = viewmodel.value as ErrorState<DomainModel>;
      expect(errorState.exception, isA<NotFoundException>());
    });
  });
}
