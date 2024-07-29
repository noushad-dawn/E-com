import 'package:ecom/const/styles.dart';
import 'package:ecom/views/authentication/forgot.dart';
import 'package:ecom/views/authentication/signup.dart';
import 'package:ecom/views/screens/bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController otpController = TextEditingController();
bool isVisible = true;
bool isActivate = false;
bool isgetOTP = true;
var value;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isMobileNumber(String input) {
    final RegExp mobileRegex = RegExp(
      r"^\+?[1-9]\d{1,14}$",
    );
    return mobileRegex.hasMatch(input);
  }

  bool _isEmail(String input) {
    final RegExp emailRegex = RegExp(
      r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
    );
    return emailRegex.hasMatch(input);
  }

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

  void _activateSignIn() {
    setState(() {
      isActivate = _isMobileNumber(emailController.text) ||
          _isEmail(emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPhoneNumber = _isMobileNumber(emailController.text);
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
                'Sign In',
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
                'Enter your email and password to \n access your account or create an account',
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Email or Phone',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          onChanged: (text) => _activateSignIn(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      isActivate
                          ? !isPhoneNumber
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Password',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.055,
                                      child: TextField(
                                        controller: passController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: isVisible,
                                        decoration: InputDecoration(
                                          suffixIcon: (isVisible
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isVisible = false;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.visibility_off),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isVisible = true;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.visibility),
                                                )),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Enter OTP',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                    Pinput(
                                      controller: otpController,
                                      length: 6,
                                      showCursor: true,
                                    ),
                                  ],
                                )
                          : const SizedBox(
                              height: 0,
                            ),
                      isgetOTP && isPhoneNumber
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: size.width / 4,
                                    height: size.height * 0.055,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Get OTP',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: whiteColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  onPressed: () async {
                                    try {
                                      try {
                                        await _auth.verifyPhoneNumber(
                                            verificationCompleted:
                                                (PhoneAuthCredential
                                                    credential) {},
                                            verificationFailed:
                                                (FirebaseAuthException ex) {
                                              _showErrorDialog(ex.message ??
                                                  'Verification failed. Please try again.');
                                            },
                                            codeSent: (String verificationid,
                                                int? resendtoken) {
                                              setState(() {
                                                value = verificationid;
                                              });
                                            },
                                            codeAutoRetrievalTimeout:
                                                (String verificationid) {},
                                            phoneNumber: '+91' +
                                                emailController.text
                                                    .toString());
                                      } catch (e) {
                                        _showErrorDialog(e.toString());
                                      }
                                      setState(() {
                                        isgetOTP = false;
                                      });
                                    } catch (e) {
                                      _showErrorDialog(
                                          "Failed to send OTP: ${e.toString()}");
                                    }
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      isActivate
                          ? CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                try {
                                  if (!isPhoneNumber) {
                                    await _auth.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text,
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BottomNavBar(),
                                      ),
                                    );
                                  } else {
                                    try {
                                      PhoneAuthCredential credential =
                                          PhoneAuthProvider.credential(
                                        verificationId: value,
                                        smsCode: otpController.text.toString(),
                                      );
                                      await _auth
                                          .signInWithCredential(credential)
                                          .then(
                                            (value) =>
                                                Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBar(),
                                              ),
                                            ),
                                          );
                                    } catch (e) {
                                      _showErrorDialog(
                                          "Failed to verify OTP: ${e.toString()}");
                                    }
                                  }
                                  emailController.clear();
                                  passController.clear();
                                  otpController.clear();
                                } on FirebaseAuthException catch (e) {
                                  String message;
                                  switch (e.code) {
                                    case 'user-not-found':
                                      message = 'No user found for that email.';
                                      break;
                                    case 'wrong-password':
                                      message = 'Wrong password provided.';
                                      break;
                                    case 'invalid-email':
                                      message = 'Invalid email provided.';
                                      break;
                                    default:
                                      message =
                                          'An error occurred. Please try again.';
                                  }
                                  _showErrorDialog(message);
                                } catch (e) {
                                  _showErrorDialog(
                                      "An error occurred: ${e.toString()}");
                                }
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 30),
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: size.height * 0.055,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: blackColor),
                            children: [
                              TextSpan(text: "Don't have an account ? "),
                              TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ForgotPass(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot password",
                          style: TextStyle(color: blackColor),
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
