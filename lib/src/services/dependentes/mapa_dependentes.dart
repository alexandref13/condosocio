class DependentesMapa {
  late String idep;
  late String nome;
  late String sobrenome;
  late String img;
  late String status;
  late String desde;
  late String ultacesso;
  late String email;
  late String tipousuario;
  late String celular;
  late String facial;
  late String condominio_facial;
  late String ctlnotificacao;

  DependentesMapa({
    required this.idep,
    required this.nome,
    required this.sobrenome,
    required this.img,
    required this.status,
    required this.desde,
    required this.ultacesso,
    required this.email,
    required this.tipousuario,
    required this.celular,
    required this.facial,
    required this.condominio_facial,
    required this.ctlnotificacao,
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
    tipousuario = json['tipousuario'];
    celular = json['celular'];
    facial = json['facial'];
    condominio_facial = json['condominio_facial'];
    ctlnotificacao = json['ctlnotificacao'];
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
    data['tipousuario'] = this.tipousuario;
    data['celular'] = this.celular;
    data['facial'] = this.facial;
    data['condominio_facial'] = this.condominio_facial;
    data['ctlnotificacao'] = this.ctlnotificacao;
    return data;
  }
}
