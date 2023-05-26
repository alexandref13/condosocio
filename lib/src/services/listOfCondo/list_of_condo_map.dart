class ListOfCondo {
  late String nomeCond;
  late String idusu;
  late String tipoun;
  late String logradouro;
  late String imglogo;
  late String idcond;
  late String tipousu;
  late String nomeusu;
  late String sobrenomeusu;

  ListOfCondo({
    required this.nomeCond,
    required this.idusu,
    required this.tipoun,
    required this.logradouro,
    required this.imglogo,
    required this.idcond,
    required this.tipousu,
    required this.nomeusu,
    required this.sobrenomeusu,
  });

  ListOfCondo.fromJson(Map<String, dynamic> json) {
    nomeCond = json['nome_cond'];
    idusu = json['idusu'];
    tipoun = json['tipoun'];
    logradouro = json['logradouro'];
    imglogo = json['imglogo'];
    idcond = json['idcond'];
    tipousu = json['tipousu'];
    nomeusu = json['nomeusu'];
    sobrenomeusu = json['sobrenomeusu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome_cond'] = this.nomeCond;
    data['idusu'] = this.idusu;
    data['tipoun'] = this.tipoun;
    data['logradouro'] = this.logradouro;
    data['imglogo'] = this.imglogo;
    data['idcond'] = this.idcond;
    data['tipousu'] = this.tipousu;
    data['nomeusu'] = this.nomeusu;
    data['sobrenomeusu'] = this.sobrenomeusu;
    return data;
  }
}
