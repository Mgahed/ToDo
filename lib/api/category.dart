import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mrttodo/controller/categoryController.dart';

import 'base.dart';

final CategoryController _categoryController = Get.find();

Future<dynamic> getCategories(token) async {
  try {
    var response = await Dio().get(
      '$baseUrl/categories',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer $token",
      }),
    );
    print("get categories ress =>>> $response");
    if (response.statusCode == 200) {
      _categoryController.setCategory(response.data["categories"]);
      return {"message": "categories fetched successfully", "status": true};
    } else {
      String error = '';
      for (var currError in response.data.errors) {
        error += '$currError\n';
      }
      return {"message": error};
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 422) {
      /*String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }*/
      return {"message": e.response?.data['errors']};
    } else {
      return {"message": "Something went wrong"};
    }
  }
}
