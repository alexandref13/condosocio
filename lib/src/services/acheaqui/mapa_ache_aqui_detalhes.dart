class MapaAcheAquiDetalhes {
  late String fantasia;
  late String imgforn;
  late String tel;
  late String cel;
  late String email;
  late String site;
  late int qtdAvaliacoes;
  late String mediaAvaliacoes;
  late String endereco;
  late String atividades;

  MapaAcheAquiDetalhes(
      {required this.fantasia,
      required this.imgforn,
      required this.tel,
      required this.cel,
      required this.email,
      required this.site,
      required this.qtdAvaliacoes,
      required this.mediaAvaliacoes,
      required this.endereco,
      required this.atividades});

  MapaAcheAquiDetalhes.fromJson(Map<String, dynamic> json) {
    fantasia = json['fantasia'];
    imgforn = json['imgforn'];
    tel = json['tel'];
    cel = json['cel'];
    email = json['email'];
    site = json['site'];
    qtdAvaliacoes = json['qtd_avaliacoes'];
    mediaAvaliacoes = json['media_avaliacoes'];
    endereco = json['endereco'];
    atividades = json['atividades'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fantasia'] = this.fantasia;
    data['imgforn'] = this.imgforn;
    data['tel'] = this.tel;
    data['cel'] = this.cel;
    data['email'] = this.email;
    data['site'] = this.site;
    data['qtd_avaliacoes'] = this.qtdAvaliacoes;
    data['media_avaliacoes'] = this.mediaAvaliacoes;
    data['endereco'] = this.endereco;
    data['atividades'] = this.atividades;
    return data;
  }
}
