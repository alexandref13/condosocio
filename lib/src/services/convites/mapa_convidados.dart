class ConvidadosMapa {
  String nome;
  String tel;
  String tipo;

  ConvidadosMapa({this.nome, this.tel, this.tipo});

  ConvidadosMapa.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    tel = json['tel'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['tel'] = this.tel;
    data['tipo'] = this.tipo;
    return data;
  }
}
