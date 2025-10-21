class PetsMapa {
  late String idpet;
  late String nome;
  late String raca;
  late String sexo;
  late String birthdate;
  late String tipo;
  late String imgpet;

  PetsMapa({
    required this.idpet,
    required this.nome,
    required this.raca,
    required this.sexo,
    required this.birthdate,
    required this.tipo,
    required this.imgpet,
  });

  PetsMapa.fromJson(Map<String, dynamic> json) {
    idpet = json['idpet'];
    nome = json['nome'];
    raca = json['raca'];
    sexo = json['sexo'];
    birthdate = json['birthdate'];
    tipo = json['tipo'];
    imgpet = json['imgpet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpet'] = this.idpet;
    data['nome'] = this.nome;
    data['raca'] = this.raca;
    data['sexo'] = this.sexo;
    data['birthdate'] = this.birthdate;
    data['tipo'] = this.tipo;
    data['imgpet'] = this.imgpet;

    return data;
  }
}
