class MapaEnquetes {
  late String idenq;
  late String titulo;
  late String datacreate;
  late String datavalida;

  MapaEnquetes(
      {required this.idenq,
      required this.titulo,
      required this.datacreate,
      required this.datavalida});

  MapaEnquetes.fromJson(Map<String, dynamic> json) {
    idenq = json['idenq'];
    titulo = json['titulo'];
    datacreate = json['datacreate'];
    datavalida = json['datavalida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idenq'] = this.idenq;
    data['titulo'] = this.titulo;
    data['datacreate'] = this.datacreate;
    data['datavalida'] = this.datavalida;
    return data;
  }
}
