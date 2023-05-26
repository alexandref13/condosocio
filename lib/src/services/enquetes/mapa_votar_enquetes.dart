class MapaVotarEnquetes {
  late String valida;
  late int qdtperguntas;
  late List<String> perguntas;
  late List<int> votacao;
  late int soma;
  late String verificavoto;

  MapaVotarEnquetes(
      {required this.valida,
      required this.qdtperguntas,
      required this.perguntas,
      required this.votacao,
      required this.soma,
      required this.verificavoto});

  MapaVotarEnquetes.fromJson(Map<String, dynamic> json) {
    valida = json['valida'];
    qdtperguntas = json['qdtperguntas'];
    perguntas = json['perguntas'].cast<String>();
    votacao = json['votacao'].cast<int>();
    soma = json['soma'];
    verificavoto = json['verificavoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valida'] = this.valida;
    data['qdtperguntas'] = this.qdtperguntas;
    data['perguntas'] = this.perguntas;
    data['votacao'] = this.votacao;
    data['soma'] = this.soma;
    data['verificavoto'] = this.verificavoto;
    return data;
  }
}
