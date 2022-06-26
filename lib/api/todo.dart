// end point that create a todoo list
// POST /todos
import 'package:dio/dio.dart';

import 'base.dart';

Future<dynamic> createTodo(data) async {
  try {
    var response = await Dio().post(
      '$baseUrl/todo/create',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${data['token']}",
      }),
    );
    print("create todo ress =>>> $response");
    if (response.statusCode == 201) {
      return {"message": "todo created successfully"};
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
