import 'package:ecom/models/vegetables.dart';

class CartItem {
  final Vegetable vegetable;
  int quantity;

  CartItem({required this.vegetable, this.quantity = 1});
}
