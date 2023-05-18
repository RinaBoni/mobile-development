import 'package:flutter/material.dart';
import './login_form.dart';
import './anonymous_routes.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/login_form': (context) => DetailScreen(),//const LoginForm(),
    },
  ),
  );  //rumApp
}