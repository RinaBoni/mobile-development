import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//наследуем все из StatelessWidget. нам нужно переопределить обстрактый метод build
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //переопределяем метод build
  //возвращает один объект типа Widget и принимает параметр типа buildContext
  @override
  Widget build(BuildContext context) {
    //возвращаем окно. в нем мы можем указать какие именно настройки, темы, виджеты и тд будут в окне
    return MaterialApp(
      //свойство, которое показывает что будет на главном экране
      //чтобы выводить много объектов используем класс Scaffold. (в home обращаемся только к одному объекту, а внутри этого объекта к множесту разных других
      home: Scaffold(
        //шапка приложения
        appBar: AppBar(
          title: const Text('Введение в виджеты'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        //основное тело приложения, расположение по центу
        body: Container(
          color: Colors.deepOrange,
          child: Text('привет flutter!'),
          alignment: Alignment.center,
        ),
      ),
    );

  }







}
