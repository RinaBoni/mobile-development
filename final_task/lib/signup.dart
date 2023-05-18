import 'package:final_task/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundSignUp(),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 25.0, top: 35.0),
                child: Icon(Icons.arrow_back_ios, color: Colors.white,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  _getHeader(),
                  _getInputs(),
                  _getSignUp(context),
                  _getBottomRow(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

_getHeader() {
  return Expanded(
    flex: 3,
    child: Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Регистрация аккаунта',
        style: TextStyle(color: Colors.white, fontSize: 37),
      ),
    ),
  );
}

_getInputs() {
  return const Expanded(
    flex: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            labelText: 'Логин',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            labelText: 'Имя',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.white)),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Пароль',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Подтвердите пароль',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

_getSignUp(context) {
  return  Expanded(
    flex: 0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context){
                      return HomeScreen();
                    })
            );
          },
          child: Text(
            'Продолжить',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    ),
  );
}

_getBottomRow(context) {
  return Expanded(
    flex: 1,
    child: Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'У меня есть аккаунт',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    ),
  );
}

class BackgroundSignUp extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.orange.shade300;
    canvas.drawPath(mainBackground, paint);

    // Blue
    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.65);
    blueWave.cubicTo(sw * 0.8, sh * 0.8, sw * 0.5, sh * 0.8, sw * 0.45, sh);
    blueWave.lineTo(0, sh);
    blueWave.close();
    paint.color = Colors.grey.shade800;
    canvas.drawPath(blueWave, paint);

    // Grey
    Path greyPath = Path();
    greyPath.lineTo(sw, 0);
    greyPath.lineTo(sw, sh * 0.3);
    greyPath.cubicTo(sw * 0.65, sh * 0.45, sw * 0.25, sh * 0.35, 0, sh * 0.5);
    greyPath.close();
    paint.color = Colors.lightBlue.shade300;
    canvas.drawPath(greyPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}