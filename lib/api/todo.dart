// end point that create a todoo list
// POST /todos
import 'package:dio/dio.dart';

import 'base.dart';

Future<dynamic> createTodo(data, token) async {
  print("create todo token =>>> $token");
  print("create todo token =>>> $data");
  try {
    var response = await Dio().post(
      '$baseUrl/todo/create',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer $token",
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
    print("create todo error =>>> ${e.response?.data['errors']}");
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

Future<dynamic> updateTodoApi(data, token) async {
  try {
    var response = await Dio().post(
      '$baseUrl/todo/update',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer $token",
      }),
    );
    print("update todo ress =>>> $response");
    if (response.statusCode == 200) {
      return {"message": "todo updated successfully", "status": true};
    } else {
      String error = '';
      for (var currError in response.data.errors) {
        error += '$currError\n';
      }
      return {"message": error, "status": false};
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 422) {
      /*String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }*/
      return {"message": e.response?.data['errors'], "status": false};
    } else {
      return {"message": "Something went wrong", "status": false};
    }
  }
}

Future<dynamic> deleteTodoApi(id, token) async {
  var data = {"id": id};
  try {
    var response = await Dio().post(
      '$baseUrl/todo/delete',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer $token",
      }),
    );
    print("delete todo ress =>>> $response");
    if (response.statusCode == 200) {
      return {"message": "todo deleted successfully", "status": true};
    } else {
      return {"message": response.data['errors'], "status": false};
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 422) {
      /*String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }*/
      return {"message": e.response?.data['errors'], "status": false};
    } else {
      return {"message": "Something went wrong", "status": false};
    }
  }
}
