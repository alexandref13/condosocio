class DadosComunicados {
  late String titulo;
  late String arquivo;
  late String dia;
  late String mes;

  DadosComunicados(
      String titulo, String arquivo, String dia, String mes, String hora) {
    this.titulo = titulo;
    this.arquivo = arquivo;
    this.dia = dia;
    this.mes = mes;
  }

  DadosComunicados.fromJson(Map json) {
    titulo = json['titulo'];
    arquivo = json['arquivo'];
    dia = json['dia'];
    mes = json['mes'];
  }
}
