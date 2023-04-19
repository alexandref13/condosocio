class VeiculosMapa {
  String idvei;
  String marca;
  String modelo;
  String cor;
  String ano;
  String placa;
  String desde;
  String contagem;
  String qtdVagas;

  VeiculosMapa({
    this.idvei,
    this.marca,
    this.modelo,
    this.cor,
    this.ano,
    this.placa,
    this.desde,
    this.contagem,
    this.qtdVagas,
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
