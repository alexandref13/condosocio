class DadosComunicados {
  String titulo;
  String texto;
  String dia;
  String mes;
  String hora;

  DadosComunicados(
      String titulo, String texto, String dia, String mes, String hora) {
    this.titulo = titulo;
    this.texto = texto;
    this.dia = dia;
    this.mes = mes;
    this.hora = hora;
  }

  DadosComunicados.fromJson(Map json) {
    titulo = json['titulo'];
    texto = json['texto'];
    dia = json['dia'];
    mes = json['mes'];
    hora = json['hora'];
  }
}
