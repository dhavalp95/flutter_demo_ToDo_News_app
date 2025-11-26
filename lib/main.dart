import 'package:flutter/material.dart';
import 'package:my_auth_app/login.dart';
import 'package:my_auth_app/todo/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // create singleton instance
  final obj = await SharedPreferences.getInstance();

  //fetch data from permanat memomry
  final isLogin = obj.getBool('is_login') ?? false;

  runApp(
    MaterialApp(
      // open root screen based on condition
      home: (isLogin) ? MyMenu() : LoginScreen(),
    ),
  );
}
