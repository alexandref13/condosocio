class VeiculosMapa {
  late String idvei;
  late String marca;
  late String modelo;
  late String cor;
  late String ano;
  late String placa;
  late String desde;
  late String contagem;
  late String qtdVagas;

  VeiculosMapa({
    required this.idvei,
    required this.marca,
    required this.modelo,
    required this.cor,
    required this.ano,
    required this.placa,
    required this.desde,
    required this.contagem,
    required this.qtdVagas,
  });

  VeiculosMapa.fromJson(Map<String, dynamic> json) {
    idvei = json['idvei'];
    marca = json['marca'];
    modelo = json['modelo'];
    cor = json['cor'];
    ano = json['ano'];
    placa = json['placa'];
    desde = json['desde'];
    contagem = json['contagem'];
    qtdVagas = json['qtdVagas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idvei'] = this.idvei;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['cor'] = this.cor;
    data['ano'] = this.ano;
    data['placa'] = this.placa;
    data['desde'] = this.desde;
    data['contagem'] = this.contagem;
    data['qtdVagas'] = this.qtdVagas;
    return data;
  }
}
