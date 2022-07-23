import 'package:beefit/controls/ApiService.dart';
import 'package:beefit/models/nutrition/Ingredient.dart';
import 'package:get/get.dart';

class NutritionController extends GetxController {
  NutritionController({required String iD}) : id = iD;
  var isShow = false.obs;
  var isLoading = true.obs;
  var ingredient = Ingredient().obs;
  String id;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNutrition(id);
  }

  fetchNutrition(String id) async {
    try {
      isLoading(true);
      ingredient.value = await ApiService.instance.fetchIngredient(id);
    } finally {
      isLoading(false);
    }
  }
}
