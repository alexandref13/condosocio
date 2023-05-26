class DadosAvisos {
  late String titulo;
  late String texto;
  late String dia;
  late String mes;
  late String hora;

  DadosAvisos(
      String titulo, String texto, String dia, String mes, String hora) {
    this.titulo = titulo;
    this.texto = texto;
    this.dia = dia;
    this.mes = mes;
    this.hora = hora;
  }

  DadosAvisos.fromJson(Map json) {
    titulo = json['titulo'];
    texto = json['texto'];
    dia = json['dia'];
    mes = json['mes'];
    hora = json['hora'];
  }
}
