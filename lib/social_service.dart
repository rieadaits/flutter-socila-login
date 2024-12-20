
import 'dart:developer';
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLogInService {
  SocialLogInService._();
  static SocialLogInService instance = SocialLogInService._();

  Map<String, dynamic>? userData;

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

  Future<String?> signInWithApple() async{

    try{
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.aboutyourapp.package',
          redirectUri:
          Uri.parse(
            'https://example.co/customer/auth/login/apple-mobile',
          ),
        ),
      );

      log("${credential.identityToken}\n");

      return credential.identityToken;
    }catch(e){
      rethrow;
    }

  }

  Future<void> signOut() async {
     await _googleSignIn.signOut();
  }
}