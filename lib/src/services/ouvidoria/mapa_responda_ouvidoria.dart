class MapaRespondaOuvidoria {
  late String idusuraiz;
  late String msgraiz;
  late String tipoouv;
  late String dataraiz;
  late String horaraiz;
  late String idusu;
  late String nomeusu;
  late String imgperfil;
  late String tipousu;
  late String texto;
  late String data;
  late String hora;

  MapaRespondaOuvidoria(
      {required this.idusuraiz,
      required this.msgraiz,
      required this.tipoouv,
      required this.dataraiz,
      required this.horaraiz,
      required this.idusu,
      required this.nomeusu,
      required this.imgperfil,
      required this.tipousu,
      required this.texto,
      required this.data,
      required this.hora});

  MapaRespondaOuvidoria.fromJson(Map<String, dynamic> json) {
    idusuraiz = json['idusuraiz'];
    msgraiz = json['msgraiz'];
    tipoouv = json['tipoouv'];
    dataraiz = json['dataraiz'];
    horaraiz = json['horaraiz'];
    idusu = json['idusu'];
    nomeusu = json['nomeusu'];
    imgperfil = json['imgperfil'];
    tipousu = json['tipousu'];
    texto = json['texto'];
    data = json['data'];
    hora = json['hora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idusuraiz'] = this.idusuraiz;
    data['msgraiz'] = this.msgraiz;
    data['tipoouv'] = this.tipoouv;
    data['dataraiz'] = this.dataraiz;
    data['horaraiz'] = this.horaraiz;
    data['idusu'] = this.idusu;
    data['nomeusu'] = this.nomeusu;
    data['imgperfil'] = this.imgperfil;
    data['tipousu'] = this.tipousu;
    data['texto'] = this.texto;
    data['data'] = this.data;
    data['hora'] = this.hora;
    return data;
  }
}
