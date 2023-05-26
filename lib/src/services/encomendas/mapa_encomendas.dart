class MapaEncomendas {
  late String idenc;
  late String codigo;
  late String tipo;
  late String info;
  late String status;
  late String morador;
  late String admCriador;
  late String dataCriada;
  late String admEntrega;
  late String idcript;
  late String dataEntrega;

  MapaEncomendas(
      {required this.idenc,
      required this.codigo,
      required this.tipo,
      required this.info,
      required this.status,
      required this.morador,
      required this.admCriador,
      required this.dataCriada,
      required this.admEntrega,
      required this.idcript,
      required this.dataEntrega});

  MapaEncomendas.fromJson(Map<String, dynamic> json) {
    idenc = json['idenc'];
    codigo = json['codigo'];
    tipo = json['tipo'];
    info = json['info'];
    status = json['status'];
    morador = json['morador'];
    admCriador = json['adm_criador'];
    dataCriada = json['data_criada'];
    admEntrega = json['adm_entrega'];
    idcript = json['idcript'];
    dataEntrega = json['data_entrega'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idenc'] = this.idenc;
    data['codigo'] = this.codigo;
    data['tipo'] = this.tipo;
    data['info'] = this.info;
    data['status'] = this.status;
    data['morador'] = this.morador;
    data['adm_criador'] = this.admCriador;
    data['data_criada'] = this.dataCriada;
    data['adm_entrega'] = this.admEntrega;
    data['idcript'] = this.idcript;
    data['data_entrega'] = this.dataEntrega;
    return data;
  }
}
