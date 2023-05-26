class MapaAcheAquiPesquisa {
  late String id;
  late String nome;
  late String imgforn;
  late String tipo;

  MapaAcheAquiPesquisa(
      {required this.id,
      required this.nome,
      required this.imgforn,
      required this.tipo});

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
