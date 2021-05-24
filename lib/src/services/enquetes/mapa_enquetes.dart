class MapaEnquetes {
  String idenq;
  String titulo;
  String datacreate;
  String datavalida;

  MapaEnquetes({this.idenq, this.titulo, this.datacreate, this.datavalida});

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
