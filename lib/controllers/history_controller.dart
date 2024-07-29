// import 'package:ecom/models/history_item.dart';
// import 'package:flutter/material.dart';

// class History with ChangeNotifier {
//   List<HistoryItem> _items = [];

//   List<HistoryItem> get items => _items;

//   void addItem(double totalAmount, String date) {
//     _items.add(HistoryItem(totalAmount: totalAmount, status: true, date: date));
//     notifyListeners();
//   }

//   void removeItem(int index) {
//     _items.removeAt(index);
//     notifyListeners();
//   }

//   void clearHistory() {
//     _items = [];
//     notifyListeners();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/models/history_item.dart';

class History with ChangeNotifier {
  List<HistoryItem> _items = [];

  List<HistoryItem> get items => _items;

  History() {
    _loadHistoryFromPreferences();
  }

  void addItem(double totalAmount, String date) {
    _items.add(HistoryItem(totalAmount: totalAmount, status: true, date: date));
    _saveHistoryToPreferences();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _saveHistoryToPreferences();
    notifyListeners();
  }

  void clearHistory() {
    _items = [];
    _saveHistoryToPreferences();
    notifyListeners();
  }

  Future<void> _saveHistoryToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyJson =
        _items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('history', historyJson);
  }

  Future<void> _loadHistoryFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? historyJson = prefs.getStringList('history');
    if (historyJson != null) {
      _items = historyJson.map((item) {
        return HistoryItem.fromJson(jsonDecode(item));
      }).toList();
      notifyListeners();
    }
  }
}
