import 'dart:async';

import 'package:ecom/const/styles.dart';
import 'package:ecom/views/authentication/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Splash());

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: primaryColor,
            image: const DecorationImage(
                image: AssetImage('assets/images/green.png'),
                fit: BoxFit.cover,
                opacity: 0.1),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 250,
              width: 250,
            ),
          ),
        ),
      ),
    );
  }
}
