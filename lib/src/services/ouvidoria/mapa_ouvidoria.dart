class MapaOuvidoria {
  late String idraiz;
  late String msg;
  late String assunto;
  late String idouv;
  late String dia;
  late String mes;
  late String ano;
  late String hora;
  late String data;

  MapaOuvidoria({
    required this.idraiz,
    required this.msg,
    required this.assunto,
    required this.idouv,
    required this.dia,
    required this.mes,
    required this.ano,
    required this.hora,
    required this.data,
  });

  MapaOuvidoria.fromJson(Map<String, dynamic> json) {
    idraiz = json['idraiz'] ?? '';
    msg = json['msg'] ?? '';
    assunto = json['assunto'] ?? '';
    idouv = json['idouv'] ?? '';
    dia = json['dia'] ?? '';
    mes = json['mes'] ?? '';
    ano = json['ano'] ?? '';
    hora = json['hora'] ?? '';
    data = json['data'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idraiz'] = this.idraiz;
    data['msg'] = this.msg;
    data['assunto'] = this.assunto;
    data['idouv'] = this.idouv;
    data['dia'] = this.dia;
    data['mes'] = this.mes;
    data['ano'] = this.ano;
    data['hora'] = this.hora;
    data['data'] = this.data;
    return data;
  }
}
