class MapaOcorrencias {
  late String id;
  late String titulo;
  late String desc;
  late String imgoco;
  late String data;
  late String hora;
  late String dataoco;
  late String horaoco;
  late String status;
  late String tipoco;
  late String dia;
  late String mes;

  MapaOcorrencias({
    required this.id,
    required this.titulo,
    required this.desc,
    required this.imgoco,
    required this.data,
    required this.hora,
    required this.dataoco,
    required this.horaoco,
    required this.status,
    required this.tipoco,
    required this.dia,
    required this.mes,
  });

  MapaOcorrencias.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    titulo = json['titulo'] ?? '';
    desc = json['desc'] ?? '';
    imgoco = json['imgoco'] ?? '';
    data = json['data'] ?? '';
    hora = json['hora'] ?? '';
    dataoco = json['dataoco'] ?? '';
    horaoco = json['horaoco'] ?? '';
    status = json['status'] ?? '0';
    tipoco = json['tipoco'] ?? '';
    dia = json['dia'] ?? '';
    mes = json['mes'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['desc'] = this.desc;
    data['imgoco'] = this.imgoco;
    data['data'] = this.data;
    data['hora'] = this.hora;
    data['dataoco'] = this.dataoco;
    data['horaoco'] = this.horaoco;
    data['status'] = this.status;
    data['tipoco'] = this.tipoco;
    data['dia'] = this.dia;
    data['mes'] = this.mes;
    return data;
  }
}
