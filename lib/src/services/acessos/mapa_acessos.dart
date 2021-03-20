class MapaAcessos {
  String idfav;
  String pessoa;
  String idace;
  String placa;
  String tipodoc;
  String documento;
  String datahora;
  String nome_dep;
  String dataent;
  String datasai;

  MapaAcessos(
      {this.idfav,
      this.pessoa,
      this.idace,
      this.placa,
      this.tipodoc,
      this.documento,
      this.datahora,
      this.nome_dep,
      this.dataent,
      this.datasai});

  MapaAcessos.fromJson(Map<String, dynamic> json) {
    idfav = json['idfav'];
    pessoa = json['pessoa'];
    idace = json['idace'];
    placa = json['placa'];
    tipodoc = json['tipodoc'];
    documento = json['documento'];
    datahora = json['datahora'];
    nome_dep = json['nome_dep'];
    dataent = json['dataent'];
    datasai = json['datasai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idfav'] = this.idfav;
    data['pessoa'] = this.pessoa;
    data['idace'] = this.idace;
    data['placa'] = this.placa;
    data['tipodoc'] = this.tipodoc;
    data['documento'] = this.documento;
    data['datahora'] = this.datahora;
    data['nome_dep'] = this.nome_dep;
    data['dataent'] = this.dataent;
    data['datasai'] = this.datasai;
    return data;
  }
}
