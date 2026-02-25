import 'package:brasil_fields/brasil_fields.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_model.dart';
import 'package:flutter/material.dart';

class CnpjCardWidget extends StatelessWidget {
  final CnpjModel cnpj;
  const CnpjCardWidget({super.key, required this.cnpj});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text('Razão social: ${cnpj.razaoSocial}'),
            if (cnpj.nomeFantasia != null && cnpj.nomeFantasia!.isNotEmpty)
              Text('Nome fantasia: ${cnpj.nomeFantasia}'),
            Text('CNPJ: ${UtilBrasilFields.obterCnpj(cnpj.cnpj)}'),
            if (cnpj.endereco.hasAddress)
              Text('Endereço: ${cnpj.endereco.fullAddress}'),
            Text(
              'Capital social: ${UtilBrasilFields.obterReal(cnpj.capitalSocial)}',
            ),
            Text('Natureza jurídica: ${cnpj.naturezaJuridica}'),
            Text(
              'CANE principal: ${cnpj.cnae.codigo} - ${cnpj.cnae.descricao}',
            ),
            if (cnpj.cnaesSecundarios.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text('CNAEs secundários:'),
                  ...cnpj.cnaesSecundarios.map(
                    (cnae) => Text('- ${cnae.codigo} - ${cnae.descricao}'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
