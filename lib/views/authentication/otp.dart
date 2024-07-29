import 'package:ecom/const/styles.dart';
import 'package:ecom/views/screens/bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController otpController = TextEditingController();

class OtpPage extends StatefulWidget {
  final String verificationid;
  OtpPage({super.key, required this.verificationid});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
                'Sign up',
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
                'We need to register your phone before getting \n started !',
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
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          textAlign: TextAlign.center,
                          'OTP verification',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.050,
                      ),
                      Center(
                        child: Pinput(
                          controller: otpController,
                          length: 6,
                          showCursor: true,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: widget.verificationid,
                              smsCode: otpController.text.toString(),
                            );
                            await _auth.signInWithCredential(credential).then(
                                  (value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavBar(),
                                    ),
                                  ),
                                );
                          } on FirebaseAuthException catch (e) {
                            String message;
                            switch (e.code) {
                              case 'invalid-verification-code':
                                message = 'The verification code is invalid.';
                                break;
                              case 'session-expired':
                                message =
                                    'The verification code has expired. Please request a new one.';
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
                            'Verify OTP',
                            style: TextStyle(
                                fontSize: 16,
                                color: whiteColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Edit the number ?',
                              style: TextStyle(color: blackColor),
                            ),
                          ),
                        ],
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
