class MapaAcessosVisu {
  int fav;
  String heart;
  String idfav;
  String pessoa;
  String idace;
  String placa;
  String tipodoc;
  String documento;
  String deletar;
  String data;
  String dataent;
  String datasai;

  MapaAcessosVisu(
      {this.fav,
      this.heart,
      this.idfav,
      this.pessoa,
      this.idace,
      this.placa,
      this.tipodoc,
      this.documento,
      this.deletar,
      this.data,
      this.dataent,
      this.datasai});

  MapaAcessosVisu.fromJson(Map<String, dynamic> json) {
    fav = json['fav'];
    heart = json['heart'];
    idfav = json['idfav'];
    pessoa = json['pessoa'];
    idace = json['idace'];
    placa = json['placa'];
    tipodoc = json['tipodoc'];
    documento = json['documento'];
    deletar = json['deletar'];
    data = json['data'];
    dataent = json['dataent'];
    datasai = json['datasai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fav'] = this.fav;
    data['heart'] = this.heart;
    data['idfav'] = this.idfav;
    data['pessoa'] = this.pessoa;
    data['idace'] = this.idace;
    data['placa'] = this.placa;
    data['tipodoc'] = this.tipodoc;
    data['documento'] = this.documento;
    data['deletar'] = this.deletar;
    data['data'] = this.data;
    data['dataent'] = this.dataent;
    data['datasai'] = this.datasai;
    return data;
  }
}
