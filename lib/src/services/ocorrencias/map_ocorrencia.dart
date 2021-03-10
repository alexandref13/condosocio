class MapaOcorrencias {
  String id;
  String titulo;
  String desc;
  String imgoco;
  String data;
  String hora;
  String dataoco;
  String horaoco;
  String status;

  MapaOcorrencias(
      {this.id,
      this.titulo,
      this.desc,
      this.imgoco,
      this.data,
      this.hora,
      this.dataoco,
      this.horaoco,
      this.status});

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
    return data;
  }
}
