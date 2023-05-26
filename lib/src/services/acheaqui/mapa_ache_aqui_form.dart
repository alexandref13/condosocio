class MapaAcheAquiForm {
  late String imgforn;
  late String id;
  late String fantasia;
  late String end;
  late String cidade;
  late String bairro;
  late String uf;
  late String tel;
  late String cel;
  late String site;
  late String atividades;

  MapaAcheAquiForm(
      {required this.imgforn,
      required this.id,
      required this.fantasia,
      required this.end,
      required this.cidade,
      required this.bairro,
      required this.uf,
      required this.tel,
      required this.cel,
      required this.site,
      required this.atividades});

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
