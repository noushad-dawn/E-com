import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(1, 153, 52, 1);
const secondColor = Color.fromRGBO(228, 244, 234, 1);
const thirdColor = Color.fromRGBO(205, 234, 214, 1);
const bodyColor = Color.fromRGBO(246, 251, 247, 1);
const whiteColor = Colors.white;
const blackColor = Colors.black;
const ratingColor = Colors.orange;

String imageFromFirebase(String imageName) {
  return 'https://firebasestorage.googleapis.com/v0/b/ecom-2e378.appspot.com/o/${imageName}?alt=media&token=088990d9-f6c5-4f77-9a66-1323ca1dc275';
}
