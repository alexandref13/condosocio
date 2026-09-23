class PetsMapa {
  late String idpet;
  late String nome;
  late String raca;
  late String sexo;
  late String birthdate;
  late String tipo;
  late String imgpet;
  late bool assinaturaAtiva;
  late String assinaturaAquisicao;
  late String assinaturaVigencia;

  PetsMapa({
    required this.idpet,
    required this.nome,
    required this.raca,
    required this.sexo,
    required this.birthdate,
    required this.tipo,
    required this.imgpet,
    this.assinaturaAtiva = false,
    this.assinaturaAquisicao = '',
    this.assinaturaVigencia = '',
  });

  PetsMapa.fromJson(Map<String, dynamic> json) {
    idpet = json['idpet'];
    nome = json['nome'];
    raca = json['raca'];
    sexo = json['sexo'];
    birthdate = json['birthdate'];
    tipo = json['tipo'];
    imgpet = json['imgpet'];
    assinaturaAtiva = json['assinatura_ativa'] == true;
    assinaturaAquisicao = json['assinatura_aquisicao'] ?? '';
    assinaturaVigencia = json['assinatura_vigencia'] ?? '';
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
    data['assinatura_ativa'] = this.assinaturaAtiva;
    data['assinatura_aquisicao'] = this.assinaturaAquisicao;
    data['assinatura_vigencia'] = this.assinaturaVigencia;

    return data;
  }
}
