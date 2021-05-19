class MapaReservas {
  String idarea;
  String nome;
  String qtdMaxConvidados;
  String termo;

  MapaReservas({this.idarea, this.nome, this.qtdMaxConvidados, this.termo});

  MapaReservas.fromJson(Map<String, dynamic> json) {
    idarea = json['idarea'];
    nome = json['nome'];
    qtdMaxConvidados = json['qtd_max_convidados'];
    termo = json['termo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idarea'] = this.idarea;
    data['nome'] = this.nome;
    data['qtd_max_convidados'] = this.qtdMaxConvidados;
    data['termo'] = this.termo;
    return data;
  }
}
