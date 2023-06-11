import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '/theme/my_theme.dart';
import 'package:url_launcher/url_launcher.dart';


class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer( //Drawer создаёт sadebar
      backgroundColor: MyTheme.colorDark,
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('RB'),
            accountEmail: Text('RB@jg.gf'),

            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      './img/sidebar_background.png'
                  ),
                  fit: BoxFit.cover,
                )
            ),
          ),


          ListTile(
            leading: const Icon(
              Icons.person,
              color: MyTheme.colorGreen,),
            title: const Text('Profile'),
            textColor: MyTheme.colorBrightPurple,
            onTap: () {Navigator.pushNamed(context, '/profile');},
          ),

          const Divider(color: MyTheme.colorPurple, thickness: 2,),

          ListTile(
            leading: const Icon(
              Icons.calculate_outlined,
              color: MyTheme.colorGreen,),
            title: const Text('Calculator'),
            textColor: MyTheme.colorBrightPurple,
            onTap: () => {_launchURL('https://okcalc.com/ru/')},
          ),

          const Divider(color: MyTheme.colorPurple, thickness: 2,),

          ListTile(
            leading: const Icon(
              Icons.sunny,
              color: MyTheme.colorGreen,),
            title: const Text('Wheather'),
            textColor: MyTheme.colorBrightPurple,
            onTap: (){_launchURL('https://yandex.ru/search/?text=погода&lr=68&clid=2456107');},
            //onTap: () => _openWeatherApp(),
          ),

          const Divider(color: MyTheme.colorPurple, thickness: 2,),

          const ListTile(
            leading: Icon(
              Icons.link,
              color: MyTheme.colorGreen,),
            title: Text('Data from IoT'),
            textColor: MyTheme.colorBrightPurple,
          ),

          const Divider(color: MyTheme.colorPurple, thickness: 2,),

          ListTile(
            leading: const Icon(
              Icons.exit_to_app_rounded,
              color: MyTheme.colorGreen,),
            title: const Text('Exit'),
            textColor: MyTheme.colorBrightPurple,
            onTap: () {Navigator.pushNamed(context, '/');},
          ),
        ],
      ),
    );
  }
}


_launchURL(String URL) async {
  final Uri url = Uri.parse(URL);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

