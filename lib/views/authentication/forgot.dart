import 'dart:async';

import 'package:ecom/const/styles.dart';
import 'package:ecom/views/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController emailController = TextEditingController();
var isLogin = false;

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
            image: DecorationImage(
                image: AssetImage('assets/images/green.png'),
                fit: BoxFit.cover,
                opacity: 0.1),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.100,
              ),
              const Text(
                'Forgot password',
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1,
                    color: whiteColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Enter your email and we'll send you a link to reset \nyour password",
                style:
                    TextStyle(wordSpacing: 2, color: whiteColor, fontSize: 15),
              ),
              SizedBox(
                height: size.height * 0.065,
              ),
              Container(
                height: size.height * 0.715,
                width: size.width * 0.930,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Email address',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          try {
                            await _auth.sendPasswordResetEmail(
                                email: emailController.text);
                            showDialog(
                              context: context,
                              builder: (context) {
                                Navigator.pop(context);
                                return AlertDialog(
                                  backgroundColor: whiteColor,
                                  contentTextStyle:
                                      const TextStyle(color: blackColor),
                                  alignment: Alignment.bottomCenter,
                                  content: Container(
                                    height: size.height * 0.040,
                                    width: size.height * 0.060,
                                    child: const Center(
                                      child: Text(
                                          'Check your email, we have sent a reset link'),
                                    ),
                                  ),
                                );
                              },
                            );

                            Timer(
                              const Duration(seconds: 3),
                              () {
                                setState(() {
                                  isLogin = true;
                                });
                                Navigator.pop(context);
                              },
                            );
                            emailController.clear();
                          } on FirebaseAuthException catch (e) {
                            String message;
                            switch (e.code) {
                              case 'invalid-email':
                                message = 'The email address is not valid.';
                                break;
                              case 'user-not-found':
                                message = 'No user found for this email.';
                                break;
                              default:
                                message =
                                    'An error occurred. Please try again.';
                            }
                            _showErrorDialog(message);
                          } catch (e) {
                            _showErrorDialog(
                                'An error occurred: ${e.toString()}');
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: size.height * 0.055,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 15,
                                color: whiteColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isLogin
                          ? TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(text: "Sign in"),
                                    TextSpan(
                                      text: " Now",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
