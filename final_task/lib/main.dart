import 'package:final_task/theme/theme_constants.dart';
import 'package:final_task/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import './signin.dart';
import './signup.dart';
import './home_screen.dart';
import './NavBar.dart';
import './theme/theme_constants.dart';

void main() => runApp(MyApp());

//ThemeManager _themeManager = ThemeManager();


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeClass.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login_form': (context) => LoginPage(),
        '/registration': (context) => SignUpPage(),
      },
    );
  }
}

