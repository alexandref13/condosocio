class MapaAcheAquiDetalhes {
  String fantasia;
  String imgforn;
  String tel;
  String cel;
  String email;
  String site;
  int qtdAvaliacoes;
  String mediaAvaliacoes;
  String endereco;
  String atividades;

  MapaAcheAquiDetalhes(
      {this.fantasia,
      this.imgforn,
      this.tel,
      this.cel,
      this.email,
      this.site,
      this.qtdAvaliacoes,
      this.mediaAvaliacoes,
      this.endereco,
      this.atividades});

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
