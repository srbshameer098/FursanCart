import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
Future<UserCredential?> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult result = await FacebookAuth.instance.login();

  // Check if the user has cancelled the login flow
  if (result.status == LoginStatus.cancelled) {
    print('Login cancelled by the user.');
    return null;
  }

  // Retrieve the access token from the result
  final AccessToken accessToken = result.accessToken!;

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
  FacebookAuthProvider.credential(accessToken.token);

  try {
    // Sign in with the credential
    final UserCredential userCredential =
    await _auth.signInWithCredential(facebookAuthCredential);

    return userCredential;
  } on FirebaseAuthException catch (e) {
    print('Failed to sign in with Facebook: $e');
    return null;
  }
}

