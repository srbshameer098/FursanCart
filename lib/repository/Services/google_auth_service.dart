

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Ui/Widgets/toast_message.dart';
import '../../bloc/Login/login_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // Add additional scopes here for other Google services
    ],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Google Sign In
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      // Begin interactive sign in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception('Google sign in failed');
      }

      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final String email = googleUser.email;

      // Create a new credential for user
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      print('Successfully signed in with Google');

      BlocProvider.of<LoginBloc>(context)
          .add(FetchLoginApi(email.toString(), '123456'));
    } on Exception catch (e) {
      print('Error signing in with Google: $e');
      ToastMessage().toastmessage(message: e.toString());
    } catch (e) {
      print('Error signing in with Google: $e');
      ToastMessage().toastmessage(message: e.toString());
    }
  }

  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email']
    );
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.accessToken!.token);
    final userData= await FacebookAuth.instance.getUserData();
    var userEmail=userData['email'];
    BlocProvider.of<LoginBloc>(context)
        .add(FetchLoginApi(userEmail.toString(), '123456'));
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // Future<UserCredential?> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult result = await FacebookAuth.instance.login();
  //
  //   // Check if the user has cancelled the login flow
  //   if (result.status == LoginStatus.cancelled) {
  //     print('Login cancelled by the user.');
  //     return null;
  //   }
  //
  //   // Retrieve the access token from the result
  //   final AccessToken accessToken = result.accessToken!;
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //   FacebookAuthProvider.credential(accessToken.token);
  //
  //   try {
  //     // Sign in with the credential
  //     final UserCredential userCredential =
  //     await _auth.signInWithCredential(facebookAuthCredential);
  //
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     print('Failed to sign in with Facebook: $e');
  //     return null;
  //   }
  // }

}
