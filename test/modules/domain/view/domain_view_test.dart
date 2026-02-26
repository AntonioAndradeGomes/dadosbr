import 'package:dadosbr/app_module.dart';
import 'package:dadosbr/core/ds/ui/app_exception_widget.dart';
import 'package:dadosbr/core/ds/ui/search_input_widget.dart';
import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:dadosbr/core/state/view_state.dart';
import 'package:dadosbr/modules/domain/models/domain_model.dart';
import 'package:dadosbr/modules/domain/view/domain_view.dart';
import 'package:dadosbr/modules/domain/viewmodel/domain_viewmodel.dart';
import 'package:dadosbr/modules/domain/widgets/domain_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDomainViewmodel extends Mock implements DomainViewmodel {
  final _state = ValueNotifier<ViewState<DomainModel>>(const IdleState());

  @override
  ViewState<DomainModel> get value => _state.value;

  @override
  void addListener(VoidCallback listener) => _state.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _state.removeListener(listener);

  // simula o fetchDomainInfo mudando o estado
  void emitSuccess(DomainModel model) => _state.value = SuccessState(model);
  void emitLoading() => _state.value = const LoadingState();
  void emitError(AppException e) => _state.value = ErrorState(e);
}

void main() {
  late MockDomainViewmodel mockViewmodel;

  final tModel = DomainModel(
    statusCode: 2,
    fqdn: 'brasilapi.com.br',
    hosts: ['bob.ns.cloudflare.com', 'lily.ns.cloudflare.com'],
    publicationStatus: 'published',
    expiresAt: DateTime(2022, 9, 23),
  );

  setUp(() {
    mockViewmodel = MockDomainViewmodel();

    if (getIt.isRegistered<DomainViewmodel>()) {
      getIt.unregister<DomainViewmodel>();
    }
    getIt.registerSingleton<DomainViewmodel>(mockViewmodel);
  });

  tearDown(() => getIt.unregister<DomainViewmodel>());

  Widget buildWidget() => const MaterialApp(home: DomainView());

  group('DomainView', () {
    testWidgets('deve exibir o campo de busca e botão', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.byType(SearchInputWidget), findsOneWidget);
      expect(find.text('Buscar'), findsOneWidget);
    });

    testWidgets('deve exibir snackbar quando submeter campo vazio', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      await tester.tap(find.text('Buscar'));
      await tester.pump();

      expect(find.text('Digite o Domínio completo'), findsOneWidget);
    });

    testWidgets('deve exibir CircularProgressIndicator no LoadingState', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      mockViewmodel.emitLoading();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('deve exibir DomainCardWidget no SuccessState', (tester) async {
      await tester.pumpWidget(buildWidget());

      mockViewmodel.emitSuccess(tModel);
      await tester.pump();

      expect(find.byType(DomainCardWidget), findsOneWidget);
      expect(find.textContaining('brasilapi.com.br'), findsOneWidget);
    });

    testWidgets('deve exibir AppExceptionWidget no ErrorState', (tester) async {
      await tester.pumpWidget(buildWidget());

      mockViewmodel.emitError(NotFoundException());
      await tester.pump();

      expect(find.byType(AppExceptionWidget), findsOneWidget);
    });
    testWidgets('deve chamar fetchDomainInfo ao submeter domínio válido', (
      tester,
    ) async {
      when(() => mockViewmodel.fetchDomainInfo(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget());

      await tester.enterText(find.byType(TextField), 'brasilapi.com.br');
      await tester.tap(find.text('Buscar'));
      await tester.pump();

      verify(() => mockViewmodel.fetchDomainInfo('brasilapi.com.br')).called(1);
    });
  });
}
