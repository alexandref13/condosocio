class MapaAcessos {
  String idfav;
  String pessoa;
  String idace;
  String placa;
  String tipodoc;
  String documento;
  String datahora;
  String nomedep;
  String dataent;
  String datasai;
  String tipopessoa;
  String cel;
  String idconv;
  String imgfacial;
  String idvis;

  MapaAcessos(
      {this.idfav,
      this.pessoa,
      this.idace,
      this.placa,
      this.tipodoc,
      this.documento,
      this.datahora,
      this.nomedep,
      this.dataent,
      this.datasai,
      this.tipopessoa,
      this.cel,
      this.idconv,
      this.imgfacial,
      this.idvis});

  MapaAcessos.fromJson(Map<String, dynamic> json) {
    idfav = json['idfav'];
    pessoa = json['pessoa'];
    idace = json['idace'];
    placa = json['placa'];
    tipodoc = json['tipodoc'];
    documento = json['documento'];
    datahora = json['datahora'];
    nomedep = json['nome_dep'];
    dataent = json['dataent'];
    datasai = json['datasai'];
    tipopessoa = json['tipopessoa'];
    cel = json['cel'];
    idconv = json['idconv'];
    imgfacial = json['imgfacial'];
    idvis = json['idvis'];
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
    data['nome_dep'] = this.nomedep;
    data['dataent'] = this.dataent;
    data['datasai'] = this.datasai;
    data['tipopessoa'] = this.tipopessoa;
    data['cel'] = this.cel;
    data['idconv'] = this.idconv;
    data['imgfacial'] = this.imgfacial;
    data['idvis'] = this.idvis;
    return data;
  }
}
