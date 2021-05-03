class ConvitesMapa {
  String idconv;
  String titulo;
  int qtdconv;

  ConvitesMapa({this.idconv, this.titulo, this.qtdconv});

  ConvitesMapa.fromJson(Map<String, dynamic> json) {
    idconv = json['idconv'];
    titulo = json['titulo'];
    qtdconv = json['qtdconv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idconv'] = this.idconv;
    data['titulo'] = this.titulo;
    data['qtdconv'] = this.qtdconv;
    return data;
  }
}
