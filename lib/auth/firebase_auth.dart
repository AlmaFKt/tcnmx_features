import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tecnamex_features/loguear/inicio_sesion.dart';
import 'package:tecnamex_features/responsive/mobile_body.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),//gonna tell us if its logged or not
        builder: (context, snapshot) {
          //if yes
          if (snapshot.hasData){
            return mobileBody();
          }
          //if not
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}