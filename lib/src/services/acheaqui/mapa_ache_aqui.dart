class MapaAcheAqui {
  late String atividade;
  late String id;

  MapaAcheAqui({required this.atividade, required this.id});

  MapaAcheAqui.fromJson(Map<String, dynamic> json) {
    atividade = json['atividade'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['atividade'] = this.atividade;
    data['id'] = this.id;
    return data;
  }
}
