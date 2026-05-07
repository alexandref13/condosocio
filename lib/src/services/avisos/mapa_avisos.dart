class DadosAvisos {
  late String titulo;
  late String texto;
  late String dia;
  late String mes;
  late String hora;
  late String dataCompleta;

  DadosAvisos.fromJson(Map json) {
    titulo       = json['titulo']        ?? '';
    texto        = json['texto']         ?? '';
    dia          = json['dia']           ?? '';
    mes          = json['mes']           ?? '';
    hora         = json['hora']          ?? '';
    dataCompleta = json['data_completa'] ?? '';
  }
}
