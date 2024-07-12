class MapaTutoriais {
  late String publi;
  late String titulo;
  late String descricao;
  late String html;

  MapaTutoriais(
      {required this.publi,
      required this.titulo,
      required this.descricao,
      required this.html});

  MapaTutoriais.fromJson(Map<String, dynamic> json) {
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
