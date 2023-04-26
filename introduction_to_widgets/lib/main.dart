import 'package:flutter/material.dart';

//с этой функции начинается выполнение приложения
void main() {
  //ф-я для создания графического интерфейса. прикрепляет определенный виджет к экрану
  runApp(
      //корневой виджет, который передается runApp
      Align(
        //выравнивание вложенных элементов по центу
        //alignment : Alignment.center,
        //Свойство дочернего виджета child если берется один дочерний виджет
        child:
        //представление в виде колонки
        Column(
            //Свойство дочерних виджетов children, если они берут список виджетов (в колонку
            children: const <Widget>[
              Text('Привет Flutter!',
                  textDirection: TextDirection.ltr),
              Text('Ивт-20',
                  textDirection: TextDirection.ltr),
              Text('Борисова Екатерина',
                  textDirection: TextDirection.ltr),
            ],

          // выравнивание по горизонтали по центру
          mainAxisAlignment: MainAxisAlignment.center,
          ),

      )
  );
}