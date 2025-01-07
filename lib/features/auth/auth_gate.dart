import 'package:appgame/features/auth/presentation/pages/login_page.dart';
import 'package:appgame/home_page.dart';
import 'package:appgame/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const RootPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}