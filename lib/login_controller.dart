import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var _googleSignin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  login() async {
    try {
      googleAccount.value = await _googleSignin.signIn();
      print(googleAccount);
    } catch (e) {
      print(e);
    }
  }
}
