import 'package:ecom/const/styles.dart';
import 'package:ecom/views/authentication/login.dart';
import 'package:ecom/views/authentication/phone.dart';
import 'package:ecom/views/screens/bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passController = TextEditingController();
var isVisible = true;

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                'Sign Up',
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
                'To get more advantages sign up your accounts \n by filling in some information',
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
                      const Text(
                        'Your name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                        child: TextField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      const Text('Email address',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      const Text('Create a password',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                        child: TextField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                            suffixIcon: (isVisible
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = false;
                                      });
                                    },
                                    icon: const Icon(Icons.visibility_off),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = true;
                                      });
                                    },
                                    icon: const Icon(Icons.visibility),
                                  )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.040,
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavBar(),
                              ),
                            );

                            emailController.clear();
                            passController.clear();
                          } on FirebaseAuthException catch (e) {
                            String message;
                            switch (e.code) {
                              case 'email-already-in-use':
                                message =
                                    'The email address is already in use by another account.';
                                break;
                              case 'weak-password':
                                message = 'The password provided is too weak.';
                                break;
                              case 'invalid-email':
                                message = 'The email address is not valid.';
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 16,
                                color: whiteColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.040,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpPhone(),
                            ),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: blackColor),
                            children: [
                              TextSpan(text: "Sign up using "),
                              TextSpan(
                                text: "Phone no.",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: blackColor),
                            children: [
                              TextSpan(text: "Sign in using "),
                              TextSpan(
                                text: "Email or Phone",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
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
