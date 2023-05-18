import 'package:flutter/material.dart';


import './NavBar.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Крутое приложение'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp13touch-space-select-202005?wid=904&hei=840&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1587460552755',
              width: 200,
            ),
            ElevatedButton(
              child: Text('Подробнее'),
              onPressed: () {Navigator.pushNamed(context,'/login_form',);},
            )
          ],
        ),
      ),
    );
  }
}