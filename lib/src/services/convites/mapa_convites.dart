class ConvitesMapa {
  String idconv;
  String titulo;
  int qtdconv;
  String datafinal;

  ConvitesMapa({this.idconv, this.titulo, this.qtdconv, this.datafinal});

  ConvitesMapa.fromJson(Map<String, dynamic> json) {
    idconv = json['idconv'];
    titulo = json['titulo'];
    qtdconv = json['qtdconv'];
    datafinal = json['datafinal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idconv'] = this.idconv;
    data['titulo'] = this.titulo;
    data['qtdconv'] = this.qtdconv;
    data['datafinal'] = this.datafinal;
    return data;
  }
}
