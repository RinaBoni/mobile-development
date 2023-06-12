import 'package:final_task/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as t;
import 'package:fluttertoast/fluttertoast.dart' as ft;

alertDialog1(String msg){
  ft.Fluttertoast.showToast(
      msg: msg,
      toastLength: ft.Toast.LENGTH_LONG,
      gravity: ft.ToastGravity.TOP,
      backgroundColor: MyTheme.colorDarkerBrightPurple,
      textColor: MyTheme.colorDarkPurple
  );
}

showCustom(BuildContext context, String msg) {
  ft.FToast fToast = ft.FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.green,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: const [
        Icon(
          Icons.check,
          color: Colors.white,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'This is a Bottom Custom Toast.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 3),
    gravity: ft.ToastGravity.BOTTOM,
  );
}


alertDialog(BuildContext context, String msg) {
  t.Toast.show(
    msg,
    textStyle: context,
    duration: t.Toast.lengthLong,
    gravity: t.Toast.bottom,
  );
}

validateEmail(String email) {
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}
