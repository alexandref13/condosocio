import 'package:get/get.dart';

class EnquetesController extends GetxController {
  var votos = 1.obs;
  var perguntaA = 0.obs;
  var perguntaB = 0.obs;

  addPerguntaA() {
    perguntaA.value++;
    votos.value++;
  }

  addPerguntaB() {
    perguntaB.value++;
    votos.value++;
  }
}
