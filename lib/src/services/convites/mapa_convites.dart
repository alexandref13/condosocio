class ConvitesMapa {
  late String idconv;
  late String titulo;
  late int qtdconv;
  late String datafinal;
  late String acesso;
  late String dia;
  late String mes;

  ConvitesMapa(
      {required this.idconv,
      required this.titulo,
      required this.qtdconv,
      required this.datafinal,
      required this.acesso,
      required this.dia,
      required this.mes});

  ConvitesMapa.fromJson(Map<String, dynamic> json) {
    idconv = json['idconv'];
    titulo = json['titulo'];
    qtdconv = json['qtdconv'];
    datafinal = json['datafinal'];
    acesso = json['acesso'];
    dia = json['dia'];
    mes = json['mes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idconv'] = this.idconv;
    data['titulo'] = this.titulo;
    data['qtdconv'] = this.qtdconv;
    data['datafinal'] = this.datafinal;
    data['acesso'] = this.acesso;
    data['dia'] = this.dia;
    data['mes'] = this.mes;
    return data;
  }
}
