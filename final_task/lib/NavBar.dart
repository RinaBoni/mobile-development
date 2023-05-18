import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import './signin.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer( //Drawer создает sadebar
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('RB'),
              accountEmail: Text('RB@jg.gf'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    './utils/1.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                //color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage(
                    './img/sidebar_background.png'
                  ),
                  fit: BoxFit.cover,
                )
              ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Профиль'),
            onTap: () => print("calc click"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calculate_outlined),
            title: Text('Калькулятор'),
            onTap: () => _openCalculator(),
          ),
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text('Погода'),
            onTap: () => _openWeatherApp(),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.link),
            title: Text('Данные с IoT'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return LoginPage();
                      })
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text('Выход'),
            onTap: () => print("выход"),
          ),
        ],
      ),
    );
  }
}

void _openCalculator() async {
  const url = 'calculator://com.google.android.calculator'; // URL схема для открытия калькулятора
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _openWeatherApp() async {
  const url = 'com.sec.android.widgetapp.ap.hero.accuweather.widget.weatherclock'; // URL схема для открытия приложения погоды
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}