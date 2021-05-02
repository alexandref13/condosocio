import 'package:condosocio/src/services/convites/mapa_convidados.dart';

class ConvitesMapa {
  String idconv;
  String titulo;
  String dateCreate;
  String datainicial;
  String datafinal;
  List<ConvidadosMapa> convidados;
  int qtdconv;

  ConvitesMapa(
      {this.idconv,
      this.titulo,
      this.dateCreate,
      this.datainicial,
      this.datafinal,
      this.convidados,
      this.qtdconv});

  ConvitesMapa.fromJson(Map<String, dynamic> json) {
    idconv = json['idconv'];
    titulo = json['titulo'];
    dateCreate = json['date_create'];
    datainicial = json['datainicial'];
    datafinal = json['datafinal'];
    if (json['convidados'] != null) {
      convidados = List<ConvidadosMapa>();
      json['convidados'].forEach((v) {
        convidados.add(ConvidadosMapa.fromJson(v));
      });
    }
    qtdconv = json['qtdconv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idconv'] = this.idconv;
    data['titulo'] = this.titulo;
    data['date_create'] = this.dateCreate;
    data['datainicial'] = this.datainicial;
    data['datafinal'] = this.datafinal;
    if (this.convidados != null) {
      data['convidados'] = this.convidados.map((v) => v.toJson()).toList();
    }
    data['qtdconv'] = this.qtdconv;
    return data;
  }
}

class Convidados {
  String nome;
  String tel;
  String tipo;

  Convidados({this.nome, this.tel, this.tipo});

  Convidados.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    tel = json['tel'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['tel'] = this.tel;
    data['tipo'] = this.tipo;
    return data;
  }
}
