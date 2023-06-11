import 'package:flutter/material.dart';
import '/theme/my_theme.dart';


import 'package:final_task/screens/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}


class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.colorDark,
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Крутое приложение', style: TextStyle(color: MyTheme.colorBrightPurple),),
        backgroundColor: MyTheme.colorPurple,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}