class ConvitesMapa {
  String idconv;
  String titulo;
  int qtdconv;
  String datafinal;
  String acesso;

  ConvitesMapa(
      {this.idconv, this.titulo, this.qtdconv, this.datafinal, this.acesso});

  ConvitesMapa.fromJson(Map<String, dynamic> json) {
    idconv = json['idconv'];
    titulo = json['titulo'];
    qtdconv = json['qtdconv'];
    datafinal = json['datafinal'];
    acesso = json['acesso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idconv'] = this.idconv;
    data['titulo'] = this.titulo;
    data['qtdconv'] = this.qtdconv;
    data['datafinal'] = this.datafinal;
    data['acesso'] = this.acesso;
    return data;
  }
}
