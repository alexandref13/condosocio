class ListOfCondo {
  String nomeCond;
  String idusu;
  String tipoun;
  String logradouro;
  String imglogo;
  String idcond;
  String tipousu;
  String nomeusu;
  String sobrenomeusu;

  ListOfCondo({
    this.nomeCond,
    this.idusu,
    this.tipoun,
    this.logradouro,
    this.imglogo,
    this.idcond,
    this.tipousu,
    this.nomeusu,
    this.sobrenomeusu,
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
    sobrenomeusu = json['sobrenome'];
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
