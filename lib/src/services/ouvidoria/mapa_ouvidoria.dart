class MapaOuvidoria {
  late Null idraiz;
  late int status;
  late String msg;
  late String assunto;
  late String idouv;
  late String data;
  late String hora;

  MapaOuvidoria(
      {required this.idraiz,
      required this.status,
      required this.msg,
      required this.assunto,
      required this.idouv,
      required this.data,
      required this.hora});

  MapaOuvidoria.fromJson(Map<String, dynamic> json) {
    idraiz = json['idraiz'];
    status = json['status'];
    msg = json['msg'];
    assunto = json['assunto'];
    idouv = json['idouv'];
    data = json['data'];
    hora = json['hora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idraiz'] = this.idraiz;
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['assunto'] = this.assunto;
    data['idouv'] = this.idouv;
    data['data'] = this.data;
    data['hora'] = this.hora;
    return data;
  }
}
