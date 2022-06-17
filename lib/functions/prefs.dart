import 'package:shared_preferences/shared_preferences.dart';

setDataPrefs(name, email, token, exp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('_name', name);
  prefs.setString('_email', email);
  prefs.setString('_token', token);
  prefs.setString('_exp', exp);
}
