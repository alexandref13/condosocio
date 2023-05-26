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
  });

  MapaOcorrencias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    desc = json['desc'];
    imgoco = json['imgoco'];
    data = json['data'];
    hora = json['hora'];
    dataoco = json['dataoco'];
    horaoco = json['horaoco'];
    status = json['status'];
    tipoco = json['tipoco'];
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
    return data;
  }
}
