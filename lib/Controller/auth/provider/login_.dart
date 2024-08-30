import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

   logProvider() {
    _loadLoginStatus();
  }

  Future<void> _loadLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print('Login Status Loaded: $_isLoggedIn');
    notifyListeners();
  }

  Future<void> setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = status;
    await prefs.setBool('isLoggedIn', status);
     print('Login Status Updated: $_isLoggedIn');
    notifyListeners();
  }
}
