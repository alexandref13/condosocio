import 'package:get/get.dart';

class EnquetesController extends GetxController {
  var votos = 0.obs;
  var perguntaA = 0.obs;
  var perguntaB = 0.obs;
  var isSelected = false.obs;
  var date = DateTime.now().obs;

  addPerguntaA() {
    perguntaA.value++;
    votos.value++;
    date.value = DateTime(
      date.value.year,
      date.value.month,
      date.value.day,
      date.value.hour,
      date.value.minute,
    );
    isSelected(true);
  }

  addPerguntaB() {
    perguntaB.value++;
    votos.value++;
    date.value = DateTime(
      date.value.year,
      date.value.month,
      date.value.day,
    );
    isSelected(true);
  }
}
