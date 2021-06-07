class DadosComunicados {
  String titulo;
  String arquivo;
  String dia;
  String mes;
  String hora;

  DadosComunicados(
      String titulo, String arquivo, String dia, String mes, String hora) {
    this.titulo = titulo;
    this.arquivo = arquivo;
    this.dia = dia;
    this.mes = mes;
    this.hora = hora;
  }

  DadosComunicados.fromJson(Map json) {
    titulo = json['titulo'];
    arquivo = json['arquivo'];
    dia = json['dia'];
    mes = json['mes'];
    hora = json['hora'];
  }
}
