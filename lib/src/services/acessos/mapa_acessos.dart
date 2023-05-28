class MapaAcessos {
  late String idfav;
  late String pessoa;
  late String idace;
  late String placa;
  late String tipodoc;
  late String documento;
  late String datahora;
  late String nomedep;
  late String dataent;
  late String datasai;
  late String tipopessoa;
  late String cel;
  late String idconv;
  late String imgfacial;
  late String idvis;
  late String ctlfacial;
  late String ctlreg;
  late String portao;
  late String acessotipo;

  MapaAcessos({
    required this.idfav,
    required this.pessoa,
    required this.idace,
    required this.placa,
    required this.tipodoc,
    required this.documento,
    required this.datahora,
    required this.nomedep,
    required this.dataent,
    required this.datasai,
    required this.tipopessoa,
    required this.cel,
    required this.idconv,
    required this.imgfacial,
    required this.idvis,
    required this.ctlfacial,
    required this.ctlreg,
    required this.portao,
    required this.acessotipo,
  });

  MapaAcessos.fromJson(Map<String, dynamic> json) {
    idfav = json['idfav'] ?? '';
    pessoa = json['pessoa'] ?? '';
    idace = json['idace'] ?? '';
    placa = json['placa'] ?? '';
    tipodoc = json['tipodoc'] ?? '';
    documento = json['documento'] ?? '';
    datahora = json['datahora'] ?? '';
    nomedep = json['nome_dep'] ?? '';
    dataent = json['dataent'] ?? '';
    datasai = json['datasai'] ?? '';
    tipopessoa = json['tipopessoa'] ?? '';
    cel = json['cel'] ?? '';
    idconv = json['idconv'] ?? '';
    imgfacial = json['imgfacial'] ?? '';
    idvis = json['idvis'] ?? '';
    ctlfacial = json['ctlfacial'] ?? '';
    ctlreg = json['ctlreg'] ?? '';
    portao = json['portao'] ?? '';
    acessotipo = json['acessotipo'] ?? '';
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
    data['ctlfacial'] = this.ctlfacial;
    data['ctlreg'] = this.ctlreg;
    data['portao'] = this.portao;
    data['acessotipo'] = this.acessotipo;
    return data;
  }
}
