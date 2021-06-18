class MapaVisualizarReservas {
  String idevento;
  String titulo;
  String descricao;
  String areacom;
  String dataAgenda;
  String horaAgenda;
  String status;
  String resposta;

  MapaVisualizarReservas(
      {this.idevento,
      this.titulo,
      this.descricao,
      this.areacom,
      this.dataAgenda,
      this.horaAgenda,
      this.status,
      this.resposta});

  MapaVisualizarReservas.fromJson(Map<String, dynamic> json) {
    idevento = json['idevento'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    areacom = json['areacom'];
    dataAgenda = json['data_agenda'];
    horaAgenda = json['hora_agenda'];
    status = json['status'];
    resposta = json['resposta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idevento'] = this.idevento;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['areacom'] = this.areacom;
    data['data_agenda'] = this.dataAgenda;
    data['hora_agenda'] = this.horaAgenda;
    data['status'] = this.status;
    data['resposta'] = this.resposta;
    return data;
  }
}
