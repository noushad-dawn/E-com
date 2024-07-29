import 'package:ecom/const/styles.dart';
import 'package:ecom/views/screens/history.dart';
import 'package:ecom/views/screens/home.dart';
import 'package:ecom/views/screens/product.dart';
import 'package:ecom/views/screens/profile_page.dart';
import 'package:flutter/material.dart';

var myIndex = 0;
var list = [
  const HomePage(),
  const ProductListScreen(),
  PaymentHistoryPage(),
  const ProfilePage(),
];

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black54,
        selectedItemColor: primaryColor,
        currentIndex: myIndex,
        onTap: (value) {
          setState(() {
            myIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
