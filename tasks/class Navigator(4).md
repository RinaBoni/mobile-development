Редкое приложение может обойтись одним окном или одной страницей. Во 
Flutter и то и другое – виджеты. Для переключения между окнами или 
виджетами нужно использовать Navigator.
Navigator – виджет-класс, позволяющий управлять стеком дочерних 
виджетов, т.е. открывать, закрывать и переключать окна или страницы. Когда 
мы используем MaterialApp, то экземпляр класса Navigator уже создан, и его 
не надо объявлять с помощью слова new.
А можно просто вызывать методы, для управления стеком виджетов:
Navigator.push;
Navigator.pushNamed;
Navigator.pop;
и другие.
1. Открытие нового окна и возврат к предыдущему
Чтобы открыть новое окно, нам нужно добавить в стек маршрутов новый 
маршрут. Это можно сделать с помощью Navigator.push, с указанием двух 
обязательных параметров: context и виджета MaterialPageRoute (или 
PageRouteBuilder).
Чтобы вернуться к предыдущему окну, используем метод Navigator.pop.
Создадим простой пример из двух окон.
В главном окне у нас будет кнопка, при нажатии на которую выполнится код 
«открытия окна»:
Navigator.push(context, MaterialPageRoute(builder: (context) => 
SecondScreen()));
Класс MaterialPageRoute позволяет открыть полноэкранное окно с 
эффектом присущим для вашей мобильной системы, это простой и удобный 
способ. Можно воспользоваться другим виджетом PageRouteBuilder, он 
более сложный по конструкции, мы рассмотрим его в конце этого урока.
Во втором окне будет кнопка возвращения к первому окну с помощью:
Navigator.pop(context);

![1](https://user-images.githubusercontent.com/83748388/234247221-2976caff-8612-46c4-a460-8619175a9a0b.png)

В виджете AppBar кнопка возврата добавляется автоматически при использовании Navigator.push, так же автоматически обрабатывается событие системной кнопки «Назад» (Back).
Листинг кода примера из двух окон
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Главное окно')),
body: Center(child: RaisedButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
}, child: Text('Открыть второе окно'))),
);
}
}

class SecondScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Второе окно')),
body: Center(child: RaisedButton(onPressed: (){
Navigator.pop(context);
}, child: Text('Назад'))),
);
}
}

void main() {
runApp(MaterialApp(
home: MainScreen(),
));
}
Минус такого подхода в том, что в большом приложении с большим количеством классов и виджетов, управлять такой структурой будет очень сложно. В каждый файл где вы будет использовать тот или иной виджет «окна» вам придется подключать его через import, и в случае замены на другой производить переименование виджета во всем проекте.
2. Использование маршрутов для навигации – routes
Поэтому чтобы избавиться от вышеуказанных проблем нужно использовать маршруты. Имена маршрутов принято использовать как пути в директориях: '/', '/client', '/client/123', и т.п.
Маршрут главного окна по умолчанию: '/'.
Когда в предыдущем примере в параметре home мы указали виджет MainScreen() – тем самым мы задали маршрут '/'.
Зададим маршруты в виджете MaterialApp через параметр routes.
routes: {
'/':(BuildContext context) => MainScreen(),
'/second':(BuildContext context) => SecondScreen()
},
Теперь параметр home со значением MainScreen() – можно удалить.
Если нам нужно изменить маршрут по умолчанию, при открытии приложения, нужно указать параметр initialRoute со значением маршрута, к примеру: initialRoute: '/second'.
Для открытия окна по маршруту нужно использовать Navigator.pushNamed.
Сделаем замену кода открытия окна с использованием маршрута:
Navigator.pushNamed(context, '/second');
Для возвращения ничего менять в коде не надо, оставляем Navigator.pop(context);
Листинг кода, пример с маршрутами:
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Главное окно')),
body: Center(child: Column(children: [
RaisedButton(onPressed: (){Navigator.pushNamed(context, '/second');}, child: Text('Открыть второе окно'))
],)),
);
}
}

class SecondScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Второе окно')),
body: Center(child: RaisedButton(onPressed: (){
Navigator.pop(context);
}, child: Text('Назад'))),
);
}
}

void main() {
runApp(MaterialApp(
initialRoute: '/',
routes: {
'/':(BuildContext context) => MainScreen(),
'/second':(BuildContext context) => SecondScreen()
}
));
}
3. Передача параметров в маршруте с помощью события onGenerateRoute
Следующая проблема, которую нужно решить – это передача параметров в маршруте. Например мы хотим передавать, в некоторых случает, число во второй виджет.
К примеру с помощью такого маршрута '/second/123'.
Если в предыдущем примере мы вызовем маршрут '/second/123' – то мы ничего не откроем: такого маршрута нет. Так как прописать все такие маршруты невозможно, то мы должны добавить обработчик onGenerateRoute в виджете MaterialApp:
routes: {
'/':(BuildContext context) => MainScreen(),
'/second':(BuildContext context) => SecondScreen()
},
onGenerateRoute: (routeSettings){
var path = routeSettings.name.split('/');

if (path[1] == "second") {
return new MaterialPageRoute(
builder: (context) => new SecondScreen(id:path[2]),
settings: routeSettings,
);
}
}
Маршрут '/second' в параметре routes можно было бы убрать, нужно только правильно написать исключение на отсутствие параметра path[2]. Но в нашем примере мы оставим его.

![2](https://user-images.githubusercontent.com/83748388/234247371-4d26732d-4a6d-4225-b105-4d0cb37e9180.png)

Листинг кода, пример с передачей параметров в маршруте:
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Главное окно')),
body: Center(child: Column(children: [
RaisedButton(onPressed: (){Navigator.pushNamed(context, '/second');}, child: Text('Открыть второе окно')),
RaisedButton(onPressed: (){Navigator.pushNamed(context, '/second/123');}, child: Text('Открыть второе окно 123')),
],)),
);
}
}

class SecondScreen extends StatelessWidget {
String _id;

SecondScreen({String id}):_id = id;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Второе окно $_id')),
body: Center(child: RaisedButton(onPressed: (){
Navigator.pop(context);
}, child: Text('Назад'))),
);
}
}

void main() {
runApp(MaterialApp(
initialRoute: '/',
routes: {
'/':(BuildContext context) => MainScreen(),
'/second':(BuildContext context) => SecondScreen()
},
onGenerateRoute: (routeSettings){
var path = routeSettings.name.split('/');

if (path[1] == "second") {
return new MaterialPageRoute(
builder: (context) => new SecondScreen(id:path[2]),
settings: routeSettings,
);
}
},
));
}
4. Открытие диалогового окна
С помощью класса Navigator можно так же открывать диалоговые или всплывающие окна.
Создадим диалоговое окно с помощью виджет-класса PageRouteBuilder и параметром opaque: false.

![3](https://user-images.githubusercontent.com/83748388/234247542-138a4fa0-960e-4d0f-a196-248c0fea2bfe.png)

Листинг кода, открытия диалогового окна:
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Больше или меньше')),
body: Center(child: Column(children: [
RaisedButton(onPressed: (){
Navigator.push(context, PageRouteBuilder(
opaque: false,
pageBuilder: (BuildContext context, _, __) => MyPopup()
));
}, child: Text('Загадать число')),
],)),
);
}
}

class MyPopup extends StatelessWidget {
@override
Widget build(BuildContext context) {
return AlertDialog(
title: Text('Ваш ответ:'),
actions: [
FlatButton(
onPressed: () {Navigator.pop(context);},
child: Text('Больше'),
),
FlatButton(
onPressed: () {Navigator.pop(context);},
child: Text('Меньше'),
),
],
);
}
}

void main() {runApp(MaterialApp(home: MainScreen()));}
5. Анимация диалогового окна
Открывающиеся окна можно проанимировать, для этого нужно добавить параметр transitionsBuilder в виджет PageRouteBuilder
Navigator.push(context, PageRouteBuilder(
opaque: false,
pageBuilder: (BuildContext context, _, __) => MyPopup(),
transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
return FadeTransition(
opacity: animation,
child: child,
);
}
));
Нижние подчеркивания играют роль переменных, т.е. вместо «_» и «__» можно было бы задать «varA» и «varB».
Так как мы не используем эти переменные, а в параметрах должны быть указаны названия для них – мы присвоили им названия «_» и «__», визуально они выглядят как прочерк.
•	FadeTransition – анимация прозрачности, opacity – текущие значение прозрачности
•	child – это виджет над которым будет производиться анимация
Интересным моментом является то что можно комбинировать анимации – как бы вкладывать их друг в друга.
Объединим две анимации: изменения прозрачности и увеличения размера.
Navigator.push(context, PageRouteBuilder(
opaque: false,
pageBuilder: (BuildContext context, _, __) => MyPopup(),
transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
print(animation);
return FadeTransition(
opacity: animation,
child: ScaleTransition(scale: animation, child: child),
);
}
));

![4](https://user-images.githubusercontent.com/83748388/234247650-a3e9d866-5bb0-4d01-a58d-d68017a1df0a.png)

6. Возвращаемое значение из диалогового окна
Чтобы получить какое-то значение из диалогового окна, нужно в функции pop после context добавить значение, которое мы будем возвращать. Тип значения может быть любым.
Для нашего примера пусть будет: Navigator.pop(context,true);
Но чтобы получить значение нужно добавить: await перед Navigator и async в RaisedButton:
//…
RaisedButton(onPressed: () async {
bool value = await Navigator.push(context, PageRouteBuilder(
//…

![5](https://user-images.githubusercontent.com/83748388/234247773-55e56ab7-47dd-4d44-aa8e-1cb424682b57.png)


