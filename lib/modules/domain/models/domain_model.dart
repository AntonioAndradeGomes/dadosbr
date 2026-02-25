import 'package:intl/intl.dart';

class DomainModel {
  final int statusCode;
  final String fqdn;
  final List<String> hosts;
  final String? publicationStatus;
  final DateTime? expiresAt;

  DomainModel({
    required this.statusCode,
    required this.fqdn,
    required this.hosts,
    required this.publicationStatus,
    required this.expiresAt,
  });

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      statusCode: json['status_code'] as int,
      fqdn: json['fqdn'] as String,
      hosts: List<String>.from(json['hosts'] as List),
      publicationStatus: json['publication-status'],
      expiresAt: json['expires-at'] == null
          ? null
          : DateTime.parse(json['expires-at'] as String),
    );
  }

  String get expiresAtFormatted {
    if (expiresAt == null) return 'Não informado';
    return DateFormat('dd/MM/yyyy').format(expiresAt!);
  }

  String get statusDescription => switch (statusCode) {
    0 => 'Domínio disponível',
    1 => 'Disponível com tickets concorrentes',
    2 => 'Domínio registrado',
    3 => 'Domínio Indisponível',
    4 => 'Domínio Inválido',
    5 => 'Domínio Aguardando processo de liberação',
    6 => 'Disponível no processo de liberação em andamento',
    7 =>
      'Disponível no processo de liberação em andamento com tickets concorrentes',
    8 => 'Erro',
    9 => 'Domínio em processo de liberação competitivo',
    10 => 'Domínio Desconhecido',
    _ => 'Status não mapeado ($statusCode)',
  };

  @override
  String toString() {
    return 'DomainModel(statusCode: $statusCode,  '
        'fqdn: $fqdn, hosts: $hosts, '
        'publicationStatus: $publicationStatus, expiresAt: $expiresAt)';
  }
}
