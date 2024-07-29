import 'package:ecom/models/address.dart';
import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  final List<Address> _addresses = [
    Address(
        title: 'Home',
        address:
            'RDA plot sanjay nagar tikrapara\nnear faizane madeena masjid'),
    Address(
        title: 'Office',
        address:
            'Shri Shankara Acharya Institute of professional\nmanagement and technolog mujgahan Raipur'),
  ];

  int? selectedAddressIndex;

  List<Address> get addresses => _addresses;

  void addAddress(String title, String address) {
    _addresses.add(Address(title: title, address: address));
    notifyListeners();
  }

  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  void selectAddress(int index) {
    selectedAddressIndex = index;
    notifyListeners();
  }
}
