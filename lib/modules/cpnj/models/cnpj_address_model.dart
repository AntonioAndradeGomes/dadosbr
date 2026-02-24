class CnpjAddressModel {
  final String? tipoLogradouro;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final String? municipio;
  final String? uf;
  final String? cep;

  const CnpjAddressModel({
    this.tipoLogradouro,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.municipio,
    this.uf,
    this.cep,
  });

  bool get hasAddress =>
      tipoLogradouro != null ||
      logradouro != null ||
      numero != null ||
      complemento != null ||
      bairro != null ||
      municipio != null ||
      uf != null ||
      cep != null;

  String get fullAddress {
    if (!hasAddress) return 'Endereço não informado';

    final parts = [
      if (tipoLogradouro != null) tipoLogradouro,
      if (logradouro != null) logradouro,
      if (numero != null) 'nº $numero',
      if (complemento != null && complemento!.isNotEmpty) complemento,
      if (bairro != null) bairro,
      if (municipio != null) municipio,
      if (uf != null) uf,
      if (cep != null) cep,
    ];
    return parts.join(', ');
  }

  factory CnpjAddressModel.fromJson(Map<String, dynamic> json) {
    return CnpjAddressModel(
      tipoLogradouro: json['descricao_tipo_de_logradouro'] as String?,
      logradouro: json['logradouro'] as String?,
      numero: json['numero'] as String?,
      complemento: json['complemento'] as String?,
      bairro: json['bairro'] as String?,
      municipio: json['municipio'] as String?,
      uf: json['uf'] as String?,
      cep: json['cep'] as String?,
    );
  }

  @override
  String toString() => 'CnpjAddressModel(address: $fullAddress)';
}
