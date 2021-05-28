class MapaAcheAquiPesquisa {
  String id;
  String nome;
  String imgforn;
  String tipo;

  MapaAcheAquiPesquisa({this.id, this.nome, this.imgforn, this.tipo});

  MapaAcheAquiPesquisa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    imgforn = json['imgforn'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['imgforn'] = this.imgforn;
    data['tipo'] = this.tipo;
    return data;
  }
}
