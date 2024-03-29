class MapaDocumentos {
  late String nome;
  late String descricao;
  late String tipodoc;
  late String imgdoc;
  late String data;

  MapaDocumentos(
      {required this.nome,
      required this.descricao,
      required this.tipodoc,
      required this.imgdoc,
      required this.data});

  MapaDocumentos.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    tipodoc = json['tipodoc'];
    imgdoc = json['imgdoc'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['tipodoc'] = this.tipodoc;
    data['imgdoc'] = this.imgdoc;
    data['data'] = this.data;
    return data;
  }
}
