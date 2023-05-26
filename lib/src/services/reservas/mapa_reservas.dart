class MapaReservas {
  late String idarea;
  late String nome;
  late String qtdMaxConvidados;
  late String termo;
  late String aprova;
  late String multi;
  late String tipo;
  late int lastTime;

  MapaReservas({
    required this.idarea,
    required this.nome,
    required this.qtdMaxConvidados,
    required this.termo,
    required this.aprova,
    required this.multi,
    required this.tipo,
    required this.lastTime,
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
