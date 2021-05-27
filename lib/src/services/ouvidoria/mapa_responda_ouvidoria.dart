class MapaRespondaOuvidoria {
  String idusuraiz;
  String msgraiz;
  String tipoouv;
  String dataraiz;
  String horaraiz;
  String idusu;
  String nomeusu;
  String imgperfil;
  String tipousu;
  String texto;
  String data;
  String hora;

  MapaRespondaOuvidoria(
      {this.idusuraiz,
      this.msgraiz,
      this.tipoouv,
      this.dataraiz,
      this.horaraiz,
      this.idusu,
      this.nomeusu,
      this.imgperfil,
      this.tipousu,
      this.texto,
      this.data,
      this.hora});

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