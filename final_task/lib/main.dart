import 'package:final_task/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:final_task/screens/login_form.dart';
import 'package:final_task/screens/signup_form.dart';
import 'package:final_task/screens/profile.dart';
import 'package:final_task/screens/home_screen.dart';
import 'package:final_task/screens/data_from_iot.dart';
import 'package:toast/toast.dart';


// class ToastContext {
//   late BuildContext context;
//
//   void init(BuildContext appContext) {
//     context = appContext;
//   }
// }

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  //final toastContext = ToastContext();
  //toastContext.init(context);
  //ToastContext().init(context);

  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {


      '/': (BuildContext context) => Scaffold(
        backgroundColor: Colors.blue, //MyTheme.colorDark,
        body: LoginForm(),
      ),



      '/registration': (BuildContext context) => Scaffold(
          backgroundColor: MyTheme.colorDark,
          body: SignupForm()),



      '/profile': (BuildContext context) => Scaffold(
        backgroundColor: MyTheme.colorDark,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile', style: TextStyle(color: MyTheme.colorBrightPurple),),
          backgroundColor: MyTheme.colorPurple,
        ),
        body: Profile()),


      '/data_from_iot': (BuildContext context) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Data from IOT', style: TextStyle(color: MyTheme.colorBrightPurple),),
            backgroundColor: MyTheme.colorPurple,
          ),
          body: RandomNumberGraph()),


      '/home_screen': (BuildContext context) => Scaffold(
          backgroundColor: MyTheme.colorDark,
          body: HomeScreen()),
    },
  ));
}




