class MapaVotarEnquetes {
  String valida;
  int qdtperguntas;
  List<String> perguntas;
  List<int> votacao;
  int soma;
  String verificavoto;

  MapaVotarEnquetes(
      {this.valida,
      this.qdtperguntas,
      this.perguntas,
      this.votacao,
      this.soma,
      this.verificavoto});

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
