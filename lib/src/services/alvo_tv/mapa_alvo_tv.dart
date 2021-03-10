class MapaAlvoTv {
  String publi;
  String titulo;
  String descricao;
  String html;

  MapaAlvoTv({this.publi, this.titulo, this.descricao, this.html});

  MapaAlvoTv.fromJson(Map<String, dynamic> json) {
    publi = json['publi'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publi'] = this.publi;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['html'] = this.html;
    return data;
  }
}
