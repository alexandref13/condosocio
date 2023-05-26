class MapaEvento {
  late int validausu;
  late String idevento;
  late String img;
  late String nome;
  late String unidade;
  late String titulo;
  late String descricao;
  late String respevent;
  late String areacom;
  late String dataAgenda;
  late String horaAgenda;
  late String ctl;
  late String status;

  MapaEvento(
      {required this.validausu,
      required this.idevento,
      required this.img,
      required this.nome,
      required this.unidade,
      required this.titulo,
      required this.descricao,
      required this.respevent,
      required this.areacom,
      required this.dataAgenda,
      required this.horaAgenda,
      required this.ctl,
      required this.status});

  MapaEvento.fromJson(Map<String, dynamic> json) {
    validausu = json['validausu'];
    idevento = json['idevento'];
    img = json['img'];
    nome = json['nome'];
    unidade = json['unidade'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    respevent = json['respevent'];
    areacom = json['areacom'];
    dataAgenda = json['data_agenda'];
    horaAgenda = json['hora_agenda'];
    ctl = json['ctl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['validausu'] = this.validausu;
    data['idevento'] = this.idevento;
    data['img'] = this.img;
    data['nome'] = this.nome;
    data['unidade'] = this.unidade;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['respevent'] = this.respevent;
    data['areacom'] = this.areacom;
    data['data_agenda'] = this.dataAgenda;
    data['hora_agenda'] = this.horaAgenda;
    data['ctl'] = this.ctl;
    data['status'] = this.status;
    return data;
  }
}
