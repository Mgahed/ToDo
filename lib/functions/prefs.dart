import 'package:get_storage/get_storage.dart';

setDataPrefs(name, email, token, exp) async {
  GetStorage getStorage = GetStorage();
  getStorage.write('_name', name);
  getStorage.write('_email', email);

  if (token != null) {
    getStorage.write('_token', token);
  }
  if (exp != null) {
    getStorage.write('_exp', exp);
  }
}

getDataPrefs() async {
  GetStorage getStorage = GetStorage();
  return {
    '_name': getStorage.read('_name') ?? '',
    '_email': getStorage.read('_email') ?? '',
    '_token': getStorage.read('_token') ?? '',
    '_exp': getStorage.read('_exp') ?? '',
  };
}
