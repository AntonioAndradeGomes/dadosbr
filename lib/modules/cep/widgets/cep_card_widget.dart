import 'package:brasil_fields/brasil_fields.dart';
import 'package:dadosbr/modules/cep/models/cep_model.dart';
import 'package:flutter/material.dart';

class CepCardWidget extends StatelessWidget {
  final CepModel cep;
  const CepCardWidget({super.key, required this.cep});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 8,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 80,
                child: AspectRatio(
                  aspectRatio: 10 / 7,
                  child: Image.network(cep.apiImage, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    'CEP: ${UtilBrasilFields.obterCep(cep.cep, ponto: false)}',
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '${cep.city} - ${cep.state}',
                    textAlign: TextAlign.start,
                  ),
                  if (cep.address != null)
                    Text('${cep.address}', textAlign: TextAlign.start),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
