class MapaOuvidoria {
  Null idraiz;
  int status;
  String msg;
  String assunto;
  String idouv;
  String data;
  String hora;

  MapaOuvidoria(
      {this.idraiz,
      this.status,
      this.msg,
      this.assunto,
      this.idouv,
      this.data,
      this.hora});

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
