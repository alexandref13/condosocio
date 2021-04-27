class Convites {
  String nome;
  String tel;
  String tipo;
  String placa;
  Convites({
    this.nome,
    this.tel,
    this.tipo,
    this.placa,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nome': nome,
        'tel': tel,
        'tipo': tipo,
        'placa': placa,
      };
}
