import 'package:dadosbr/modules/cpnj/models/cnae_model.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_address_model.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_model.dart';
import 'package:dadosbr/modules/cpnj/widgets/cnpj_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tModel = CnpjModel(
    cnpj: '19131243000197',
    razaoSocial: 'OPEN KNOWLEDGE BRASIL',
    nomeFantasia: 'REDE PELO CONHECIMENTO LIVRE',
    capitalSocial: 60.06,
    naturezaJuridica: 'Associação Privada',
    cnae: CnaeModel(
      codigo: 9430800,
      descricao: 'Atividades de associações de defesa de direitos sociais',
    ),
    cnaesSecundarios: [
      CnaeModel(
        codigo: 9493600,
        descricao: 'Atividades de organizações associativas',
      ),
      CnaeModel(
        codigo: 6204000,
        descricao: 'Consultoria em tecnologia da informação',
      ),
    ],
    endereco: const CnpjAddressModel(
      tipoLogradouro: 'AVENIDA',
      logradouro: 'PAULISTA',
      numero: '37',
      complemento: 'ANDAR 4',
      bairro: 'BELA VISTA',
      municipio: 'SAO PAULO',
      uf: 'SP',
      cep: '01311902',
    ),
  );

  final tModelMin = CnpjModel(
    cnpj: '19131243000197',
    razaoSocial: 'OPEN KNOWLEDGE BRASIL',
    nomeFantasia: null,
    capitalSocial: 0,
    naturezaJuridica: 'Associação Privada',
    cnae: CnaeModel(
      codigo: 9430800,
      descricao: 'Atividades de associações de defesa de direitos sociais',
    ),
    cnaesSecundarios: [],
    endereco: const CnpjAddressModel(),
  );

  Widget buildWidget(CnpjModel model) => MaterialApp(
    home: Scaffold(body: CnpjCardWidget(cnpj: model)),
  );

  group('CnpjCardWidget', () {
    group('campos obrigatórios', () {
      testWidgets('deve exibir a razão social', (tester) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(find.textContaining('OPEN KNOWLEDGE BRASIL'), findsOneWidget);
      });

      testWidgets('deve exibir o CNPJ formatado', (tester) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(find.textContaining('19.131.243/0001-97'), findsOneWidget);
      });

      testWidgets('deve exibir o capital social formatado', (tester) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(find.textContaining('Capital social'), findsOneWidget);
      });

      testWidgets('deve exibir a natureza jurídica', (tester) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(
          find.text('Natureza jurídica: Associação Privada'),
          findsOneWidget,
        );
      });

      testWidgets('deve exibir o CNAE principal com código e descrição', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(
          find.textContaining(
            'Atividades de associações de defesa de direitos sociais',
          ),
          findsOneWidget,
        );
      });
    });

    group('Nome fantasia', () {
      testWidgets('deve exibir nome fantasia quando preenchido', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(
          find.text('Nome fantasia: REDE PELO CONHECIMENTO LIVRE'),
          findsOneWidget,
        );
      });
      testWidgets('não deve exibir nome fantasia quando nulo', (tester) async {
        await tester.pumpWidget(buildWidget(tModelMin));

        expect(find.textContaining('Nome fantasia'), findsNothing);
      });

      testWidgets('não deve exibir nome fantasia quando vazio', (tester) async {
        final model = CnpjModel(
          cnpj: tModelMin.cnpj,
          razaoSocial: tModelMin.razaoSocial,
          nomeFantasia: '',
          capitalSocial: tModelMin.capitalSocial,
          naturezaJuridica: tModelMin.naturezaJuridica,
          cnae: tModelMin.cnae,
          cnaesSecundarios: [],
          endereco: const CnpjAddressModel(),
        );

        await tester.pumpWidget(buildWidget(model));

        expect(find.textContaining('Nome fantasia'), findsNothing);
      });
    });

    group('Endereço', () {
      testWidgets('deve exibir endereço quando hasAddress for true', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(find.textContaining('Endereço'), findsOneWidget);
        expect(find.textContaining('SAO PAULO'), findsOneWidget);
      });

      testWidgets('não deve exibir endereço quando hasAddress for false', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(tModelMin));

        expect(find.textContaining('Endereço'), findsNothing);
      });
    });

    group('CNAEs secundários', () {
      testWidgets('deve exibir lista de CNAEs secundários quando não vazia', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(tModel));

        expect(find.text('CNAEs secundários:'), findsOneWidget);
        expect(
          find.textContaining('Atividades de organizações associativas'),
          findsOneWidget,
        );
        expect(
          find.textContaining('Consultoria em tecnologia da informação'),
          findsOneWidget,
        );
      });

      testWidgets('não deve exibir CNAEs secundários quando lista vazia', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(tModelMin));

        expect(find.text('CNAEs secundários:'), findsNothing);
      });
    });
  });
}
