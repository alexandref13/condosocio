class MapaAcessosSaida {
  String nome;
  String imgaut;
  String idaut;
  String doc;
  String datacreate;
  String datasaida;
  String tipo;

  MapaAcessosSaida(
      {this.nome,
      this.imgaut,
      this.idaut,
      this.doc,
      this.datacreate,
      this.datasaida,
      this.tipo});

  MapaAcessosSaida.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    imgaut = json['imgaut'];
    idaut = json['idaut'];
    doc = json['doc'];
    datacreate = json['datacreate'];
    datasaida = json['datasaida'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['imgaut'] = this.imgaut;
    data['idaut'] = this.idaut;
    data['doc'] = this.doc;
    data['datacreate'] = this.datacreate;
    data['datasaida'] = this.datasaida;
    data['tipo'] = this.tipo;
    return data;
  }
}
