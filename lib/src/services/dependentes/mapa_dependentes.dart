class DependentesMapa {
  String idep;
  String nome;
  String sobrenome;
  String img;
  String status;
  String desde;
  String ultacesso;
  String email;

  DependentesMapa({
    this.idep,
    this.nome,
    this.sobrenome,
    this.img,
    this.status,
    this.desde,
    this.ultacesso,
    this.email,
  });

  DependentesMapa.fromJson(Map<String, dynamic> json) {
    idep = json['idep'];
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    img = json['img'];
    status = json['status'];
    desde = json['desde'];
    ultacesso = json['ultacesso'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idep'] = this.idep;
    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    data['img'] = this.img;
    data['status'] = this.status;
    data['desde'] = this.desde;
    data['ultacesso'] = this.ultacesso;
    data['email'] = this.email;
    return data;
  }
}