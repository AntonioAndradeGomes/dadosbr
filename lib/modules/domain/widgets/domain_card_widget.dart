import 'package:dadosbr/modules/domain/models/domain_model.dart';
import 'package:flutter/material.dart';

class DomainCardWidget extends StatelessWidget {
  final DomainModel domainModel;
  const DomainCardWidget({super.key, required this.domainModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text('Domínio: ${domainModel.fqdn}'),
            Text('Status do domínio: ${domainModel.statusDescription}'),
            if (domainModel.publicationStatus != null)
              Text('Status de publicação: ${domainModel.publicationStatus}'),
            Text('Data de expiração: ${domainModel.expiresAtFormatted}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text('Hosts (servidores DNS):'),
                ...domainModel.hosts.map((host) => Text('- $host')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
