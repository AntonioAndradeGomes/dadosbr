class CnaeModel {
  final int codigo;
  final String descricao;

  const CnaeModel({required this.codigo, required this.descricao});

  factory CnaeModel.fromJson(Map<String, dynamic> json) {
    return CnaeModel(
      codigo: json['codigo'] as int,
      descricao: json['descricao'] as String,
    );
  }

  @override
  String toString() {
    return 'CnaeModel(codigo: $codigo, descricao: $descricao)';
  }
}
