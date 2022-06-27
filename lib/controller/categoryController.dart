import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList categories = [].obs;

  void setCategory(comingCat) {
    categories.value = comingCat;
  }
}
