
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
class SocialLogInService {
  SocialLogInService._();
  static SocialLogInService instance = SocialLogInService._();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<String?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Get auth details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      log("google-Token: ${googleAuth.accessToken}");
      return googleAuth.accessToken;
    } catch (e) {
      // Log or handle the error
      rethrow;
    }
  }
  Future<void> signOutWithGoogle() async =>
      await _googleSignIn.signOut();
}