import 'package:flutter/material.dart';
import 'package:final_task/common/com_helper.dart';
import 'package:final_task/common/getTextFromField.dart';
import 'package:final_task/database_handler/db_helper.dart';
import 'package:final_task/model/user_model.dart';
import 'package:final_task/screens/signup_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'package:final_task/theme/my_theme.dart';
import 'profile.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
  //ToastContext().init(context);
}

class ToastContext {
  late BuildContext context;

  void init(BuildContext appContext) {
    context = appContext;
  }
}

class _LoginFormState extends State<LoginForm> {
  final toastContext = ToastContext();
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    toastContext.init(context);
  }

  late bool ok;

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      // Toast.show("Toast plugin app", duration: Toast.lengthShort, gravity:  Toast.bottom);
      alertDialog1("Please Enter User ID");
      alertDialog1( "Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog1( "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushNamed(context, '/profile');
          });
        } else {
          alertDialog1( "Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        alertDialog1( "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.colorDark,
      body: SingleChildScrollView(

        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                    padding: EdgeInsets.fromLTRB(
                        50.0,
                        MediaQuery.of(context).size.height * 0.2,
                        50.0, 50.0),
                    child: const FittedBox(
                      child: Text("Sign In",
                          style: TextStyle(
                              color: MyTheme.colorDarkerBrightPurple,
                              fontWeight: FontWeight.bold),
                          textScaleFactor: 3.0),
                    )),


                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: getTextFormField(
                        controller: _conUserId,
                        icon: Icons.person,
                        hintName: 'User ID'),
                  ),
                ),



                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: getTextFormField(
                      controller: _conPassword,
                      icon: Icons.lock,
                      hintName: 'Password',
                      isObscureText: true,
                    ),
                  ),
                ),



                Container(
                  margin: const EdgeInsets.all(30.0),
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //   color: Colors.blue,
                  //   borderRadius: BorderRadius.circular(30.0),
                  // ),
                  child: ElevatedButton(
                    style: MyTheme.buttonStyleUsual1,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: MyTheme.colorBrightPurple),
                    ),
                    onPressed: (){
                      login();
                      //Navigator.pushNamed(context, '/home_screen');
                    },
                  ),
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Does not have account? ',style: TextStyle(color: MyTheme.colorBrightPurple)),
                      ElevatedButton(
                        style: MyTheme.buttonStyleUsual1,
                        child: const Text('Signup', style: TextStyle(color: MyTheme.colorBrightPurple)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignupForm()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}