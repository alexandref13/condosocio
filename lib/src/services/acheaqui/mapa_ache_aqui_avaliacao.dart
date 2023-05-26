class MapaAcheAquiAvaliacao {
  late String comentario;
  late String usuario;
  late String condominio;
  late String data;
  late String estrelas;

  MapaAcheAquiAvaliacao(
      {required this.comentario,
      required this.usuario,
      required this.condominio,
      required this.data,
      required this.estrelas});

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
