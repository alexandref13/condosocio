class MapaAcheAquiForm {
  String imgforn;
  String id;
  String fantasia;
  String end;
  String cidade;
  String bairro;
  String uf;
  String tel;
  String cel;
  String site;
  String atividades;

  MapaAcheAquiForm(
      {this.imgforn,
      this.id,
      this.fantasia,
      this.end,
      this.cidade,
      this.bairro,
      this.uf,
      this.tel,
      this.cel,
      this.site,
      this.atividades});

  MapaAcheAquiForm.fromJson(Map<String, dynamic> json) {
    imgforn = json['imgforn'];
    id = json['id'];
    fantasia = json['fantasia'];
    end = json['end'];
    cidade = json['cidade'];
    bairro = json['bairro'];
    uf = json['uf'];
    tel = json['tel'];
    cel = json['cel'];
    site = json['site'];
    atividades = json['atividades'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgforn'] = this.imgforn;
    data['id'] = this.id;
    data['fantasia'] = this.fantasia;
    data['end'] = this.end;
    data['cidade'] = this.cidade;
    data['bairro'] = this.bairro;
    data['uf'] = this.uf;
    data['tel'] = this.tel;
    data['cel'] = this.cel;
    data['site'] = this.site;
    data['atividades'] = this.atividades;
    return data;
  }
}
