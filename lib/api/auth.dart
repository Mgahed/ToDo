import 'package:dio/dio.dart';
import 'package:mrttodo/api/base.dart';

Future<String> signUp(data) async {
  try {
    var response = await Dio().post(
      '$baseUrl/users',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      }),
    );
    print("ress =>>> $response");
    if (response.statusCode == 201) {
      return 'signed up successfully';
    } else {
      String error = '';
      for (var currError in response.data.errors) {
        error += '$currError\n';
      }
      return error;
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 422) {
      String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }
      return error;
    } else {
      return 'Something went wrong';
    }
  }
}

Future<dynamic> login(data) async {
  try {
    var response = await Dio().post(
      '$baseUrl/auth/login',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      }),
    );
    print("ress =>>> $response");
    if (response.statusCode == 200) {
      var token = response.data['token'];
      var expireToken = response.data['exp'];
      var name = response.data['user']['username'];
      var email = response.data['user']['email'];
      return {
        "token": token,
        "expireToken": expireToken,
        "name": name,
        "email": email,
        "message": "login successfully"
      };
    } else {
      String error = '';
      for (var currError in response.data.errors) {
        error += '$currError\n';
      }
      return {"message": error};
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 422) {
      String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }
      return {"message": error};
    } else {
      return {"message": 'Something went wrong check your credentials'};
    }
  }
}
