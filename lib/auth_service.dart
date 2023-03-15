import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_page.dart';
import 'home_page_admin.dart';
import 'login_page.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);
  late GoogleSignInAccount? _googleUser;

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              final email = user.email;
              if (email != null && email == 'reddy.20@iitj.ac.in') {
                return HomePage_Admin();
              } else {
                return HomePage();
              }
            }
          }
          return const LoginPage();
        });
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      // Check the user's email address
      final email = _googleUser!.email;
      if (email.endsWith('@iitj.ac.in')) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
        await _googleUser!.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        // Sign out and show an error message
        await signOut();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('You are not an IITJ user.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }

    return null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
