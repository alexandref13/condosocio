class MapaAcheAquiAvaliacao {
  String comentario;
  String usuario;
  String condominio;
  String data;
  String estrelas;

  MapaAcheAquiAvaliacao(
      {this.comentario,
      this.usuario,
      this.condominio,
      this.data,
      this.estrelas});

  MapaAcheAquiAvaliacao.fromJson(Map<String, dynamic> json) {
    comentario = json['comentario'];
    usuario = json['usuario'];
    condominio = json['condominio'];
    data = json['data'];
    estrelas = json['estrelas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comentario'] = this.comentario;
    data['usuario'] = this.usuario;
    data['condominio'] = this.condominio;
    data['data'] = this.data;
    data['estrelas'] = this.estrelas;
    return data;
  }
}
