class MapaAcessosSaida {
  late String nome;
  late String imgaut;
  late String idaut;
  late String doc;
  late String datacreate;
  late String datasaida;
  late String tipo;

  MapaAcessosSaida(
      {required this.nome,
      required this.imgaut,
      required this.idaut,
      required this.doc,
      required this.datacreate,
      required this.datasaida,
      required this.tipo});

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
