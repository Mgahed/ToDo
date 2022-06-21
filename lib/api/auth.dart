import 'package:dio/dio.dart';
import 'package:mrttodo/api/base.dart';
import 'package:mrttodo/functions/prefs.dart';

// signUp api call
Future<String> signUp(data) async {
  try {
    var response = await Dio().post(
      '$baseUrl/users',
      data: {"user": data},
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

// login api call
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
      /*String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }*/
      return {"message": e.response?.data['errors']};
    } else {
      return {"message": 'Something went wrong check your credentials'};
    }
  }
}

// get user data api call
Future<dynamic> getUserData(token) async {
  try {
    var response = await Dio().get(
      '$baseUrl/user/profile',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer $token",
      }),
    );
    print("ress =>>> $response");
    if (response.statusCode == 200) {
      var name = response.data['user']['username'];
      var email = response.data['user']['email'];
      setDataPrefs(name, email, null, null);
      return {"message": "User data retrieved successfully", "status": true};
    } else {
      String error = '';
      for (var currError in response.data.errors) {
        error += '$currError\n';
      }
      return {"message": error, "status": false};
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }
      return {"message": error, "status": false};
    } else {
      return {"message": 'Something went wrong', "status": false};
    }
  }
}

// update user data api call
Future<dynamic> updateUserData(token, data) async {
  try {
    if (data['password'] == '') {
      data.remove('password');
    }
    if (data['username'] == '') {
      data.remove('username');
    }
    var response = await Dio().post(
      '$baseUrl/user/update',
      data: {"user": data},
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer $token",
      }),
    );
    print("ress =>>> $response");
    if (response.statusCode == 200) {
      var name = response.data['username'];
      var email = response.data['email'];
      setDataPrefs(name, email, null, null);
      return {"message": "User data updated successfully", "status": true};
    } else {
      String error = '';
      for (var currError in response.data.errors) {
        error += '$currError\n';
      }
      return {"message": error, "status": false};
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      String error = '';
      for (var currError in e.response?.data['errors']) {
        error += '\n$currError';
      }
      return {"message": error, "status": false};
    } else {
      return {"message": 'Something went wrong', "status": false};
    }
  }
}

// logout api call
Future<dynamic> logout(token) async {
  try {
    var response = await Dio().post(
      '$baseUrl/auth/logout',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer $token",
      }),
    );
    print("ress =>>> $response");
    if (response.statusCode == 200) {
      setDataPrefs('', '', '', '');
      return {"message": "logout successfully", "status": true};
    } else {
      String error = '';
      for (var currError in response.data.errors) {
        error += '$currError\n';
      }
      return {"message": error};
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      return {"message": e.response?.data['errors'], "status": false};
    } else {
      return {"message": 'Something went wrong', "status": false};
    }
  }
}
