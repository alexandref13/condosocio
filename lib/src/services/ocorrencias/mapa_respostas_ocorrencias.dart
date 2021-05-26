class MapaRespostasOcorrencia {
  String idusu;
  String nomeusu;
  String imgperfil;
  String tipousu;
  String texto;
  String data;
  String hora;
  String idraiz;
  String dataraiz;
  String horaraiz;

  MapaRespostasOcorrencia(
      {this.idusu,
      this.nomeusu,
      this.imgperfil,
      this.tipousu,
      this.texto,
      this.data,
      this.hora,
      this.idraiz,
      this.dataraiz,
      this.horaraiz});

  MapaRespostasOcorrencia.fromJson(Map<String, dynamic> json) {
    idusu = json['idusu'];
    nomeusu = json['nomeusu'];
    imgperfil = json['imgperfil'];
    tipousu = json['tipousu'];
    texto = json['texto'];
    data = json['data'];
    hora = json['hora'];
    idraiz = json['idraiz'];
    dataraiz = json['dataraiz'];
    horaraiz = json['horaraiz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idusu'] = this.idusu;
    data['nomeusu'] = this.nomeusu;
    data['imgperfil'] = this.imgperfil;
    data['tipousu'] = this.tipousu;
    data['texto'] = this.texto;
    data['data'] = this.data;
    data['hora'] = this.hora;
    data['idraiz'] = this.idraiz;
    data['dataraiz'] = this.dataraiz;
    data['horaraiz'] = this.horaraiz;
    return data;
  }
}
