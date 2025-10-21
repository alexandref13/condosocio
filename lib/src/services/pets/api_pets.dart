import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/pets_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiPets {
  /// Envia os dados do pet (e opcionalmente a imagem) para o backend.
  /// Retorna exatamente o que o PHP responde: "1" (sucesso) ou "0" (falha).
  static Future<String> sendPets(String path) async {
    // Reutiliza as instâncias já registradas dos controllers
    final loginController = Get.find<LoginController>();
    final petsController = Get.find<PetsController>();

    // Converte a data para o formato do MySQL (yyyy-MM-dd)
    final rawBirth = petsController.birthdate.value.text.trim();
    final birthIso = rawBirth.isEmpty ? '' : _toIsoDate(rawBirth);

    print('Petsidusu: ${loginController.id.value}');
    print('tipo: ${petsController.tipos.value}');
    print('nome: ${petsController.nome.value.text}');
    print('raca: ${petsController.raca.value.text}');
    print('sexo: ${petsController.sexo.value}');
    print('birthdate(raw): $rawBirth  -> (iso): $birthIso');
    print('image path: "${path.isNotEmpty ? path : '(sem imagem)'}"');

    try {
      final uri =
          Uri.parse("https://www.condosocio.com.br/flutter/pets_inc.php");
      final request = http.MultipartRequest('POST', uri)
        ..fields['idusu'] = loginController.id.value
        ..fields['tipo'] = petsController.tipos.value
        ..fields['nome'] = petsController.nome.value.text
        ..fields['raca'] = petsController.raca.value.text
        ..fields['sexo'] = petsController.sexo.value
        ..fields['birthdate'] = birthIso;

      if (path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', path));
      }

      final streamed = await request.send();
      final res = await http.Response.fromStream(streamed);
      final body = res.body.trim();

      print('pets_inc.php -> status=${res.statusCode} body="$body"');

      // O PHP devolve "1" ou "0" no corpo.
      // Se por algum motivo vier vazio mas 200, tratamos como "0".
      if (res.statusCode == 200 && (body == '1' || body == '0')) {
        return body;
      }
      return '0';
    } catch (e, s) {
      print('ApiPets.sendPets ERROR: $e');
      print(s);
      return '0';
    }
  }

  /// Busca dados de um pet específico (conforme o controller).
  static Future<http.Response> getPets() async {
    LoginController loginController = Get.put(LoginController());

    try {
      final resp = await http.post(
        Uri.https('www.condosocio.com.br', '/flutter/pets_buscar.php'),
        body: {'idusu': loginController.id.value},
      );
      print('pets_buscar.php -> status=${resp.statusCode}');
      return resp;
    } catch (e, s) {
      print('ApiPets.getPets ERROR: $e');
      print(s);
      rethrow;
    }
  }

  static Future<http.Response> deletePets(String idpet, String idusu) async {
    final uri =
        Uri.parse('https://www.condosocio.com.br/flutter/pet_excluir.php');

    final response = await http.post(
      uri,
      body: {
        'idpet': idpet,
        'idusu': idusu,
      },
    );

    return response;
  }

  /// Converte "dd/MM/yyyy" para "yyyy-MM-dd".
  static String _toIsoDate(String ddmmyyyy) {
    final p = ddmmyyyy.split('/');
    if (p.length != 3) return '';
    final d = p[0].padLeft(2, '0');
    final m = p[1].padLeft(2, '0');
    final y = p[2];
    // Validação simples
    if (y.length != 4) return '';
    return '$y-$m-$d';
  }
}
