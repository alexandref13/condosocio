class MapaRespostasOcorrencia {
  late String idusu;
  late String nomeusu;
  late String imgperfil;
  late String tipousu;
  late String texto;
  late String data;
  late String hora;
  late String idraiz;
  late String dataraiz;
  late String horaraiz;

  MapaRespostasOcorrencia(
      {required this.idusu,
      required this.nomeusu,
      required this.imgperfil,
      required this.tipousu,
      required this.texto,
      required this.data,
      required this.hora,
      required this.idraiz,
      required this.dataraiz,
      required this.horaraiz});

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
