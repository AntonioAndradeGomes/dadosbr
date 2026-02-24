import 'package:dadosbr/modules/cpnj/models/cnae_model.dart';
import 'package:dadosbr/modules/cpnj/models/cnpj_address_model.dart';

class CnpjModel {
  final String cnpj;
  final String razaoSocial;
  final String? nomeFantasia;
  final double capitalSocial;
  final String naturezaJuridica;
  final CnaeModel cnae;
  final List<CnaeModel> cnaesSecundarios;
  final CnpjAddressModel endereco;

  CnpjModel({
    required this.cnpj,
    required this.cnae,
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.capitalSocial,
    required this.naturezaJuridica,
    required this.cnaesSecundarios,
    required this.endereco,
  });

  factory CnpjModel.fromJson(Map<String, dynamic> json) {
    return CnpjModel(
      cnpj: json['cnpj'] as String,
      razaoSocial: json['razao_social'] as String,
      nomeFantasia: json['nome_fantasia'] as String?,
      capitalSocial: (json['capital_social'] as num).toDouble(),
      naturezaJuridica: json['natureza_juridica'] as String,
      cnaesSecundarios: (json['cnaes_secundarios'] as List<dynamic>)
          .map((e) => CnaeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cnae: CnaeModel(
        codigo: json['cnae_fiscal'] as int,
        descricao: json['cnae_fiscal_descricao'] as String,
      ),
      endereco: CnpjAddressModel.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'CnpjModel(cnpj: $cnpj, razaoSocial: $razaoSocial, '
        'nomeFantasia: $nomeFantasia, capitalSocial: $capitalSocial, '
        'naturezaJuridica: $naturezaJuridica, '
        'cnaesSecundarios: $cnaesSecundarios, endereco: $endereco)';
  }
}
