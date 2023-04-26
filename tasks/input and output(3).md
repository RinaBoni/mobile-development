# Форма ввода, проверка правильного ввода
Ввод информации в программу стал важной частью с появлением компьютеров. Способы внесения информации совершенствуются, но основными остаются формы ввода содержащие текстовые поля, списки, переключатели (радиокнопки) и флажки (чекбоксы).

Перед использованием внесенных данных важно проверить их после ввода:

* внесены ли данные в обязательные поля;
* соответствует ли содержимое значению поля (например, в поле возраст должно быть целочисленное число);
* выбрано значение в группе переключателей;
* и т.д.
  
## 1. class Form()

Главным контейнером для формы является виджет-класс `Form`, он позволяет объединить в себе поля ввода. Обращаясь к состоянию формы `FormState`, можно проверить корректное заполнение полей, сбросить значения по умолчанию и сохранить значения.

Создадим виджет-класс `MyForm` от супер-класса `StatefulWidget`, который при построении будет возвращать виджет `Form`. Такая конструкция позволит перерисовать изменения в форме с помощью `setState((){})`, например: нажатие на чекбокс или радиокнопку сменит их состояние, но не изменит их внешнего вида, пока не будут отрисованы заново.

```
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return new Form(key: _formKey, child: new Column());
  }
}

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Flutter.su - Форма ввода')),
            body: new MyForm()
        )
    )
);
```

Мы указали параметр `key` со значение `_formKey` – данная константа позволит нам обращаться из дочерних элементов к функционалу формы для проверки данных, сохранения или сброса значений.

## 2. `class TextFormField()` – текстовое поле ввода

Добавим в форму текстовое поле ввода, заголовок перед ним и кнопку для инициализации проверки данных.
```
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formKey, child: new
    Column(children: <Widget>[
      new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value){
        if (value.isEmpty) return 'Пожалуйста введите свое имя';
      }),

      new SizedBox(height: 20.0),

      new RaisedButton(onPressed: (){
        if(_formKey.currentState.validate()) Scaffold.of(context).showSnackBar(SnackBar(content: Text('Форма 
        успешно заполнена'), backgroundColor: Colors.green,));
        }, child: Text('Проверить'), color: Colors.blue, textColor: Colors.white,),
    ],)));
  }
}

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Flutter.su - Форма ввода')),
            body: new MyForm()
        )
    )
);
```
* `return Container(padding: EdgeInsets.all(10.0), child: new Form(…` – виджет формы мы обернули контейнером с отступами.
* `new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),)` – добавили заголовок перед полем ввода
* `new TextFormField(` – виджет текстового поля ввода
* `validator: (value){}()` – эту функцию будет инициализировать виджет `Form`, когда мы обратимся к ней для проверки данных `_formKey.currentState.validate()`
* `validator: (value){if (value.isEmpty) return 'Пожалуйста введите свое имя';}` – проверяем значение в форме, если оно пустое `isEmpty`, значит возвращаем строку-ошибку.
* `new SizedBox(height: 20.0)` – создаем контейнер для визуального разделения виджетов между собой по вертикали
* `new RaisedButton(onPressed: (){` – создаем виджет кнопки, в предыдущих уроках мы использовали `FlatButton` (это непринципиально)
* `if(_formKey.currentState.validate())` – проверяем, проходят ли проверку поля ввода, если у полей ввода есть функции проверки в параметре `validator`. 
  
Чтобы `_formKey.currentState.validate()` вернул значение `true ==` в полях нет ошибок, все функции должны вернуть значение `null` (т.е. ничего не возвращать или `return null`).

Если какое-то поле вернуло ошибку, то под полем появится сообщение об ошибке.

Если все поля прошли проверку, мы вызываем: `Scaffold.of(context).showSnackBar(SnackBar(content: Text('Форма успешно заполнена'), backgroundColor: Colors.green,));` – всплывающее уведомление внизу экрана.

![1](https://user-images.githubusercontent.com/83748388/234246610-f3dd0ef2-0aba-4757-b9cb-848a73a16a99.png)

## 3. Проверка поля E-mail
Текстовое значение электронного адреса должно быть правильно набрано если мы хотим потом связаться по нему с человеком. Самая простая проверка которую можно придумать – это проверить есть ли символ `@` в строке. Для этого можно было бы использовать такую проверку:
```
validator: (value){
  if (value.isEmpty) return 'Пожалуйста введите свой E-mail';
  if (!value.contains('@')) return 'Это не E-mail';
}
```
Но такая простая проверка не исключает множества других ошибок при заполнении, поэтому мы предлагаем другой вариант с использованием регулярных выражений:
```
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State{
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formKey, child: new
    Column(children: <Widget>[
      new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value){
        if (value.isEmpty) return 'Пожалуйста введите свое имя';
      }),

      new SizedBox(height: 20.0),

      new Text('Контактный E-mail:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value){
        if (value.isEmpty) return 'Пожалуйста введите свой Email';

        String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-
        ]{0,25})+";
        RegExp regExp = new RegExp(p);

        if (regExp.hasMatch(value)) return null;

        return 'Это не E-mail';
      }),

      new SizedBox(height: 20.0),

      new RaisedButton(onPressed: (){
        if(_formKey.currentState.validate()) Scaffold.of(context).showSnackBar(SnackBar(content: Text('Форма 
        успешно заполнена'), backgroundColor: Colors.green,));
        }, child: Text('Проверить'), color: Colors.blue, textColor: Colors.white,),
    ],)));
  }
}

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Flutter.su - Форма ввода')),
            body: new MyForm()
        )
    )
);
```
Данный вариант проверки тоже не исключает ошибок, если, например, пользователь ошибется при написании имени своей почты.

Если пакет `validator` не устанавливается, смотрите заметку: [Возможные проблемы при обновлении до версии Flutter Release Preview 2 и Dart SDK 2.1.0](https://flutter.su/note/1)

Есть модуль написанный на дарт [«validator» pub.dartlang.org/packages/validator](https://pub.dev/packages/validator), если его подключить, то можно проверять множество типов, с его помощью можно проверить и e-mail простой функцией `isEmail(String str)` которая скрывает от нас реализацию.

![2](https://user-images.githubusercontent.com/83748388/234246693-dfd6e6ec-815a-4c37-a088-b1b58cdf6e90.png)

## 4. `class RadioListTile()` – переключатель (радиокнопка)
Переключатели объединяются в группу по параметру, который они изменяют. Так, например, добавим переключатели к нашей форме с выбором мужского или женского пола.

Можно определить переменную `_gender`, для группировки переключателей, в нашем виджете с целочисленным значением, где `0` – мужской пол, а `1` – женский пол:
```
class MyFormState extends State{
  final _formKey = GlobalKey
  //тогда сами переключатели имели бы такой вид:
  new Text('Ваш пол:', style: TextStyle(fontSize: 20.0),),

  new RadioListTile(
    title: const Text('Мужской'),
    value: 0,
    groupValue: _gender,
    onChanged: (int value) {setState(() { _gender = value;});},
  ),

  new RadioListTile(
    title: const Text('Женский'),
    value: 1,
    groupValue: _gender,
    onChanged: (int value) {setState(() { _gender = value;});},
  ),

  new SizedBox(height: 20.0),
//…
```
* `groupValue: _gender` – группировка переключателей по значению, а также значение по умолчанию.

Если бы в классе `MyFormState` мы объявили `int _gender = 0` – то по умолчанию был бы выбран мужской пол.

* `onChanged: (int value) {setState(() { _gender = value;});}` – когда мы нажимаем на переключатель и меняем его состояние, происходит событие в котором мы меняем значение на новое и запрашиваем перестроение нашего виджета `MyFormState` с помощью `setState((){});` В полной реализации мы решили отойти от `int` значений для выбора пола и создали перечисление `GenderList` с помощью типа `enum`. Для этого в файле `main.dart` пишем:
  
```
import 'package:flutter/material.dart';

enum GenderList {male, female}
/*
Теперь там где мы использовали int – меняем на GenderList и
значения 0 на GenderList.male и 1 на GenderList.female:
GenderList _gender;
*/
new Text('Ваш пол:', style: TextStyle(fontSize: 20.0),),

new RadioListTile(
  title: const Text('Мужской'),
  value: GenderList.male,
  groupValue: _gender,
  onChanged: (GenderList value) {setState(() { _gender = value;});},
),

new RadioListTile(
  title: const Text('Женский'),
  value: GenderList.female,
  groupValue: _gender,
  onChanged: (GenderList value) {setState(() { _gender = value;});},
),

new SizedBox(height: 20.0),
```
## 5. `class CheckboxListTile()` – флажок (чекбокс)

Флажки помогают включить или выключить конкретный параметр. В нашей форме мы добавим флажок для получения согласия на обработку персональных данных.

Добавим переменную «согласия» `_agreement` типа `bool` в наш класс:
```
class MyFormState extends State{
  final _formKey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;
```
* `true` – флажок установлен, пользователь согласен
* `false` – флажок снят, пользователь не принял соглашение.
  
Добавим флажок, который будет менять значение переменной `_agreement`:

```
new SizedBox(height: 20.0),

new CheckboxListTile(
  value: _agreement,
  title: new Text('Я ознакомлен'+(_gender==null?'(а)':_gender==GenderList.male?'':'а')+' с документом Согласие на обработку персональных данных" и даю согласие на обработку моих персональных данных в соответствии с требованиями "Федерального закона О персональных данных № 152-ФЗ".'),
  onChanged: (bool value) => setState(() => _agreement = value)
),
```
## 6. Проверка `class RadioListTile()` и `class CheckboxListTile()`

Проверку текстовых полей при нажатии на кнопку «Проверить» мы проводили так:
```
new RaisedButton(onPressed: (){
  if(_formKey.currentState.validate())
```
И если функция в значения `validator` в текстовых полях не возвращала ошибок, мы выводили сообщение об успешном заполнении формы:
```
Scaffold.of(context).showSnackBar(SnackBar(content: Text('Форма успешно заполнена'), 
backgroundColor: Colors.green,)
```
Но у виджетов `RadioListTile` и `CheckboxListTile` нет параметра `validator` для функции проверки.Поэтому мы должны встроить проверку значений переключателей и флажков после или до основной проверки форм `if(_formKey.currentState.validate())`
```
new RaisedButton(onPressed: (){
if(_formKey.currentState.validate()) {
Color color = Colors.red;
String text;

if (_gender == null) text = 'Выберите свой пол';
else if (_agreement == false) text = 'Необходимо принять условия соглашения';
else {text = 'Форма успешно заполнена'; color = Colors.green;}

Scaffold.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: color,));
}
}, child: Text('Проверить'), color: Colors.blue, textColor: Colors.white,),
```
![3](https://user-images.githubusercontent.com/83748388/234246744-0b4ce75f-a824-40ef-936f-900a80aaaebc.png)

## 7. Полный листинг программы форма с проверкой
```
import 'package:flutter/material.dart';

enum GenderList {male, female}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;

  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formKey, child: new
    Column(children: <Widget>[
    new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),),
        new TextFormField(validator: (value){
          if (value.isEmpty) return 'Пожалуйста введите свое имя';
        }),

        new SizedBox(height: 20.0),

        new Text('Контактный E-mail:', style: TextStyle(fontSize: 20.0),),
        new TextFormField(validator: (value){
          if (value.isEmpty) return 'Пожалуйста введите свой Email';

          String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-
          ]{0,25})+";
          RegExp regExp = new RegExp(p);

          if (regExp.hasMatch(value)) return null;

          return 'Это не E-mail';
        }),

        new SizedBox(height: 20.0),

        new Text('Ваш пол:', style: TextStyle(fontSize: 20.0),),

        new RadioListTile(
          title: const Text('Мужской'),
          value: GenderList.male,
          groupValue: _gender,
          onChanged: (GenderList value) {setState(() { _gender = value;});},
        ),

        new RadioListTile(
          title: const Text('Женский'),
          value: GenderList.female,
          groupValue: _gender,
          onChanged: (GenderList value) {setState(() { _gender = value;});},
        ),

        new SizedBox(height: 20.0),

        new CheckboxListTile(
            value: _agreement,
            title: new Text('Я ознакомлен'+(_gender==null?'(а)':_gender==GenderList.male?'':'а')+' с документом "Согласие на обработку персональных данных" и даю согласие на обработку моих персональных данных в соответствии с требованиями "Федерального закона О персональных данных № 152-ФЗ".'),
            onChanged: (bool value) => setState(() => _agreement = value)
    ),

    new SizedBox(height: 20.0),

    new RaisedButton(onPressed: (){
    if(_formKey.currentState.validate()) {
    Color color = Colors.red;
    String text;

    if (_gender == null) text = 'Выберите свой пол';
    else if (_agreement == false) text = 'Необходимо принять условия соглашения';
    else {text = 'Форма успешно заполнена'; color = Colors.green;}

    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: color,));
    }
    }, child: Text('Проверить'), color: Colors.blue, textColor: Colors.white,),
    ],)));
  }
}

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Flutter.su - Форма ввода')),
            body: new MyForm()
        )
    )
);
```
## 8. Задание для практики: калькулятор площади

![4](https://user-images.githubusercontent.com/83748388/234246794-15db30bd-4552-4029-a92e-062838585d82.png)

Ниже будет приведен листинг кода калькулятора площади, его вы можете использовать для задания или написать свой.

*Задание:*
1. Добавить переключатели между единицами измерения: мм, см, м и т.д.
2. Задать значения по умолчанию.
3. Изменить тип `int` на `double`

Для выполнения задания вам понадобится параметр `initialValue: 'String'` в классе `TextFormField` – задает значение текстового поля по умолчанию.
`import 'package:flutter/material.dart';`


[красивый](https://translated.turbopages.org/proxy_u/en-ru.ru.a24d1295-64492b4f-6c6de927-74722d776562/https/www.geeksforgeeks.org/form-validation-in-flutter/)

[то что нужно исправить](https://flutter.su/tutorial/4-forma-vvoda-proverka)

[видео по этой залупе](https://www.youtube.com/watch?v=GZ-CDwbDPDQ&t=16s)