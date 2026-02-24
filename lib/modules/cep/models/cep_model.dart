class CepModel {
  final String cep;
  final String state;
  final String city;
  final String? neighborhood;
  final String? street;
  final String service;

  const CepModel({
    required this.cep,
    required this.state,
    required this.city,
    this.neighborhood,
    this.street,
    required this.service,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) {
    return CepModel(
      cep: json['cep'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      neighborhood: json['neighborhood'],
      street: json['street'],
      service: json['service'] as String,
    );
  }

  String? get address {
    if (neighborhood == null || street == null) return null;
    return '$street, $neighborhood';
  }

  String get apiImage =>
      'https://atlasescolar.ibge.gov.br/images/bandeiras/ufs/${state.toLowerCase()}.png';

  @override
  String toString() {
    return 'CepModel(cep: $cep, state: $state, city: $city, '
        'neighborhood: $neighborhood, street: $street, service: $service)';
  }
}
