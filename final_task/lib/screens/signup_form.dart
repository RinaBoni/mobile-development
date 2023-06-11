import 'package:flutter/material.dart';
import 'package:final_task/common/com_helper.dart';
import 'package:final_task/common/getTextFromField.dart';
import 'package:final_task/database_handler/db_helper.dart';
import 'package:final_task/model/user_model.dart';
import 'package:final_task/screens/login_form.dart';
import 'package:final_task/theme/my_theme.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Password Mismatch');
      } else {
        _formKey.currentState!.save();

        UserModel uModel = UserModel(uid, uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Saved");

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginForm()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "Error: Data Save Fail");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.colorDark,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //genLoginSignupHeader('Signup'),
                  Container(
                    //padding: const EdgeInsets.all(50.0),
                      padding: EdgeInsets.fromLTRB(
                          50.0,
                          MediaQuery.of(context).size.height * 0.1,
                          50.0, 40.0),
                      child: const FittedBox(
                        child: Text("Sign Up",
                            style: TextStyle(
                                color: MyTheme.colorBrightPurple,
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
                          controller: _conUserName,
                          icon: Icons.person_outline,
                          inputType: TextInputType.name,
                          hintName: 'User Name'),
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: getTextFormField(
                          controller: _conEmail,
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          hintName: 'Email'),
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
                        isObscureText: true,),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: getTextFormField(
                        controller: _conCPassword,
                        icon: Icons.lock,
                        hintName: 'Confirm Password',
                        isObscureText: true,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: MyTheme.buttonStyleUsual1,
                      child: Text(
                        'Signup', style: TextStyle(color: MyTheme.colorBrightPurple)
                      ),
                      onPressed:(){
                        signUp;
                        Navigator.pushNamed(context, '/home_screen');
                      }
                    ),
                  ),


                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Does you have account? ',style: TextStyle(color: MyTheme.colorBrightPurple)),
                        ElevatedButton(
                          style: MyTheme.buttonStyleUsual1,
                          child: Text('Sign In', style: TextStyle(color: MyTheme.colorBrightPurple)),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginForm()),
                                  (Route<dynamic> route) => false,
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
      ),
    );
  }
}
