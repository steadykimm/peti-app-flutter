import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUser(User? newUser) {
    _user = newUser;
    notifyListeners();
  }

  void alert(String title, String message, {VoidCallback? okCallback}) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              if (okCallback != null) {
                okCallback();
              }
            },
          ),
        ],
      ),
    );
  }
}
