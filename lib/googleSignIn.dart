import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GooglSignInApi {
  static final _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '259405143833-eee43ndvhcij40u7n0571n54nbuhff1m.apps.googleusercontent.com' //web
        : '', //android
  );

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();
}
