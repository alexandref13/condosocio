class DadosComunicados {
  late String titulo;
  late String arquivo;
  late String dia;
  late String mes;
  late String dataCompleta;

  DadosComunicados(String titulo, String arquivo, String dia, String mes,
      String dataCompleta) {
    this.titulo = titulo;
    this.arquivo = arquivo;
    this.dia = dia;
    this.mes = mes;
    this.dataCompleta = dataCompleta;
  }

  DadosComunicados.fromJson(Map json) {
    titulo = json['titulo'];
    arquivo = json['arquivo'];
    dia = json['dia'];
    mes = json['mes'];
    dataCompleta = json['data_completa'] ?? '';
  }
}
