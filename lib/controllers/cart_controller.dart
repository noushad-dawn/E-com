// import 'package:ecom/models/card_items.dart';
// import 'package:ecom/models/vegetables.dart';
// import 'package:flutter/material.dart';

// class Cart with ChangeNotifier {
//   List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   void addItem(Vegetable vegetable) {
//     for (CartItem item in _items) {
//       if (item.vegetable.name == vegetable.name) {
//         item.quantity++;

//         notifyListeners();
//         return;
//       }
//     }
//     _items.add(CartItem(vegetable: vegetable));
//     notifyListeners();
//   }

//   void removeItem(Vegetable vegetable) {
//     _items.removeWhere((item) => item.vegetable.name == vegetable.name);
//     notifyListeners();
//   }

//   double get totalAmount {
//     double total = 0.0;
//     for (CartItem item in _items) {
//       total += item.vegetable.price * item.quantity;
//     }
//     return total;
//   }

//   void clearCart() {
//     _items = [];
//     notifyListeners();
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/models/vegetables.dart';
import 'package:ecom/models/card_items.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  Cart() {
    _loadCartFromPreferences();
  }

  void addItem(Vegetable vegetable) {
    for (CartItem item in _items) {
      if (item.vegetable.name == vegetable.name) {
        item.quantity++;
        _saveCartToPreferences();
        notifyListeners();
        return;
      }
    }
    _items.add(CartItem(vegetable: vegetable));
    _saveCartToPreferences();
    notifyListeners();
  }

  void removeItem(Vegetable vegetable) {
    _items.removeWhere((item) => item.vegetable.name == vegetable.name);
    _saveCartToPreferences();
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    for (CartItem item in _items) {
      total += item.vegetable.price * item.quantity;
    }
    return total;
  }

  void clearCart() {
    _items = [];
    _saveCartToPreferences();
    notifyListeners();
  }

  Future<void> _saveCartToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJson = _items
        .map((item) => jsonEncode({
              'vegetable': item.vegetable.toJson(),
              'quantity': item.quantity,
            }))
        .toList();
    await prefs.setStringList('cart', cartJson);
  }

  Future<void> _loadCartFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cart');
    if (cartJson != null) {
      _items = cartJson.map((item) {
        Map<String, dynamic> cartMap = jsonDecode(item);
        Vegetable vegetable = Vegetable.fromJson(cartMap['vegetable']);
        return CartItem(
          vegetable: vegetable,
          quantity: cartMap['quantity'],
        );
      }).toList();
      notifyListeners();
    }
  }
}
