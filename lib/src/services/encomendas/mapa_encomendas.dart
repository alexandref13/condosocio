class MapaEncomendas {
  String idenc;
  String codigo;
  String tipo;
  String info;
  String status;
  String morador;
  String admCriador;
  String dataCriada;
  String admEntrega;
  String idcript;
  String dataEntrega;

  MapaEncomendas(
      {this.idenc,
      this.codigo,
      this.tipo,
      this.info,
      this.status,
      this.morador,
      this.admCriador,
      this.dataCriada,
      this.admEntrega,
      this.idcript,
      this.dataEntrega});

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
