class MapaVisualizarReservas {
  late String idevento;
  late String titulo;
  late String descricao;
  late String areacom;
  late String dataAgenda;
  late String horaAgenda;
  late String status;
  late String resposta;
  late String termo;

  MapaVisualizarReservas({
    required this.idevento,
    required this.titulo,
    required this.descricao,
    required this.areacom,
    required this.dataAgenda,
    required this.horaAgenda,
    required this.status,
    required this.resposta,
    required this.termo,
  });

  MapaVisualizarReservas.fromJson(Map<String, dynamic> json) {
    idevento = json['idevento'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    areacom = json['areacom'];
    dataAgenda = json['data_agenda'];
    horaAgenda = json['hora_agenda'];
    status = json['status'];
    resposta = json['resposta'];
    termo = json['termo'];
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
    data['termo'] = this.termo;
    return data;
  }
}
