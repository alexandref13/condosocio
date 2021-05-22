class MapaEvento {
  String idevento;
  String img;
  String nome;
  String unidade;
  String titulo;
  String descricao;
  String respevent;
  String areacom;
  String dataAgenda;
  String status;
  int validausu;

  MapaEvento({
    this.idevento,
    this.img,
    this.nome,
    this.unidade,
    this.titulo,
    this.descricao,
    this.respevent,
    this.areacom,
    this.dataAgenda,
    this.validausu,
    this.status,
  });

  MapaEvento.fromJson(Map<String, dynamic> json) {
    idevento = json['idevento'];
    img = json['img'];
    nome = json['nome'];
    unidade = json['unidade'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    respevent = json['respevent'];
    areacom = json['areacom'];
    dataAgenda = json['data_agenda'];
    status = json['status'];
    validausu = json['validausu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idevento'] = this.idevento;
    data['img'] = this.img;
    data['nome'] = this.nome;
    data['unidade'] = this.unidade;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['respevent'] = this.respevent;
    data['areacom'] = this.areacom;
    data['data_agenda'] = this.dataAgenda;
    data['status'] = this.status;
    data['validausu'] = this.validausu;
    return data;
  }
}
