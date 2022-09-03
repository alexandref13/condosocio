class MapaReservas {
  String idarea;
  String nome;
  String qtdMaxConvidados;
  String termo;
  String aprova;
  String multi;
  String tipo;
  int lastTime;

  MapaReservas({
    this.idarea,
    this.nome,
    this.qtdMaxConvidados,
    this.termo,
    this.aprova,
    this.multi,
    this.tipo,
    this.lastTime,
  });

  MapaReservas.fromJson(Map<String, dynamic> json) {
    idarea = json['idarea'];
    nome = json['nome'];
    qtdMaxConvidados = json['qtd_max_convidados'];
    termo = json['termo'];
    aprova = json['aprova'];
    multi = json['multi'];
    tipo = json['tipo'];
    lastTime = json['lastTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idarea'] = this.idarea;
    data['nome'] = this.nome;
    data['qtd_max_convidados'] = this.qtdMaxConvidados;
    data['termo'] = this.termo;
    data['aprova'] = this.aprova;
    data['multi'] = this.multi;
    data['tipo'] = this.tipo;
    data['lastTime'] = this.lastTime;
    return data;
  }
}
