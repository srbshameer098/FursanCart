// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
//
// final _facebookLogin = FacebookLogin();
//
// Future<FacebookAccessToken?> _logInWithFacebook() async {
//   final result = await _facebookLogin.logIn(['email']);
//
//   switch (result.status) {
//     case FacebookLoginStatus.cancelledByUser:
//       print('Login cancelled by the user.');
//       return null;
//     case FacebookLoginStatus.error:
//       print('Something went wrong with the login process.');
//       return null;
//     case FacebookLoginStatus.loggedIn:
//       final FacebookAccessToken accessToken = result.accessToken;
//       return accessToken;
//     default:
//       print('Unknown login status.');
//       return null;
//   }
// }
