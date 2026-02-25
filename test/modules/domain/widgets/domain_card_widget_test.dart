import 'package:dadosbr/modules/domain/models/domain_model.dart';
import 'package:dadosbr/modules/domain/widgets/domain_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tModel = DomainModel(
    statusCode: 2,
    fqdn: 'brasilapi.com.br',
    hosts: ['bob.ns.cloudflare.com', 'lily.ns.cloudflare.com'],
    publicationStatus: 'published',
    expiresAt: DateTime(2022, 9, 23),
  );

  Widget buildWidget() => MaterialApp(
    home: Scaffold(body: DomainCardWidget(domainModel: tModel)),
  );

  group('DomainCardWidget', () {
    testWidgets('Deve exibir o fqdn do domínio', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.text('Domínio: ${tModel.fqdn}'), findsOneWidget);
    });

    testWidgets('Deve exibir o statusDescription correto', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(
        find.text('Status do domínio: ${tModel.statusDescription}'),
        findsOneWidget,
      );
    });

    testWidgets('Deve exibir o publicationStatus quando não nulo', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      expect(
        find.text('Status de publicação: ${tModel.publicationStatus}'),
        findsOneWidget,
      );
    });

    testWidgets('Não deve exibir publicationStatus quando nulo', (
      tester,
    ) async {
      final modelNotStatus = DomainModel(
        statusCode: 2,
        fqdn: 'brasilapi.com.br',
        hosts: ['bob.ns.cloudflare.com'],
        publicationStatus: null,
        expiresAt: DateTime(2022, 9, 23),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DomainCardWidget(domainModel: modelNotStatus)),
        ),
      );

      expect(find.textContaining('Status de publicação'), findsNothing);
    });

    testWidgets('Deve exibir a data de expiração formatada', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.text('Data de expiração: 23/09/2022'), findsOneWidget);
    });

    testWidgets('deve exibir "Não informado" quando expiresAt for nulo', (
      tester,
    ) async {
      final modelNotData = DomainModel(
        statusCode: 2,
        fqdn: 'brasilapi.com.br',
        hosts: ['bob.ns.cloudflare.com'],
        publicationStatus: 'published',
        expiresAt: null,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DomainCardWidget(domainModel: modelNotData)),
        ),
      );

      expect(find.text('Data de expiração: Não informado'), findsOneWidget);
    });

    testWidgets('Deve exibir todos os hosts', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.text('- bob.ns.cloudflare.com'), findsOneWidget);
      expect(find.text('- lily.ns.cloudflare.com'), findsOneWidget);
    });
  });
}
