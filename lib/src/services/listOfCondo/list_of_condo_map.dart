class ListOfCondo {
  String nomeCond;
  String idusu;
  String tipoun;
  String logradouro;
  String imglogo;

  ListOfCondo(
      {this.nomeCond, this.idusu, this.tipoun, this.logradouro, this.imglogo});

  ListOfCondo.fromJson(Map<String, dynamic> json) {
    nomeCond = json['nome_cond'];
    idusu = json['idusu'];
    tipoun = json['tipoun'];
    logradouro = json['logradouro'];
    imglogo = json['imglogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome_cond'] = this.nomeCond;
    data['idusu'] = this.idusu;
    data['tipoun'] = this.tipoun;
    data['logradouro'] = this.logradouro;
    data['imglogo'] = this.imglogo;
    return data;
  }
}
