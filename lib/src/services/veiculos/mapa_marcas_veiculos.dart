class MarcasMapa {
  String idmarca;
  String nome;

  MarcasMapa({
    this.idmarca,
    this.nome,
  });

  MarcasMapa.fromJson(Map<String, dynamic> json) {
    idmarca = json['marca'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idmarca'] = this.idmarca;
    data['nome'] = this.nome;
    return data;
  }
}
