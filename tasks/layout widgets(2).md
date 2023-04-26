# Контейнеры компоновки `layout widgets`
Чтобы организовать и расположить определенным образом один виджет или наборы виджетов 
применяются специальные виджеты - контейнеры компоновки (`layout widgets`), которые 
управляют компоновкой виджетов (в том числе и других контейнеров). Во Flutter эта группа 
виджетов очень широко представлена. Рассмотрим некоторые из них.

## `Align`
Виджет `Align` позволяет позиционировать вложенный элемент относительно определенной 
стороны контейнера. По умолчанию он растягивается по всей ширине и высоте контейнера, 
заполняя все его пространство.

Для создания виджета применяется следующий конструктор:

`Align({Key key, AlignmentGeometry alignment: Alignment.center, double widthFactor, double 
heightFactor, Widget child})`

Как видно из сигнатуры конструктора все его параметры необязательные. Для установки 
вложенного элемента, к которому будет применяться выравнивание по определенному краю 
контейнера, используется параметр `child` - в его качестве может выступать любой объект `Widget`, 
то есть любой виджет.

Дополнительные параметры `widthFactor` и `heightFactor` коэффициент изменения ширины и высоты виджета `Center` относительно вложенного дочернего элемента. Например, если `widthFactor` равен `2.0`, то ширина виджета `Center` будет равна ширине дочернего элемента, умноженной на `2.0`. То же самое касается и `heightFactor`, только он изменяет высоту.

Для установки выравнивания применяется параметр `alignment`, который представляет класс `AlignmentGeometry` и может принимать следующие значения:

* `Alignment.bottomCenter:` выравнивание по горизонтали по центру, по вертикали - у нижнего края контейнера (внизу по центру). Аналогично значению `Alignment(0.0, 1.0)`

* `Alignment.bottomLeft:` выравнивание по горизонтали по левому краю, по вертикали - у нижнего края контейнера (внизу слева). Аналогично значению `Alignment(-1.0, 1.0)`

* `Alignment.bottomRight` : выравнивание по горизонтали по правому краю, по вертикали - у нижнего края контейнера (внизу справа). Аналогично значению `Alignment(1.0, 1.0)`

* `Alignment.center`: выравнивание по горизонтали и по вертикали по центру. Аналогично значению `Alignment(0.0, 0.0)`

* `Alignment.centerLeft`: выравнивание по горизонтали по левому краю, по вертикали - по центру контейнера. Аналогично значению `Alignment(-1.0, 0.0)`

* `Alignment.centerRight`: выравнивание по горизонтали по правому краю, по вертикали - по центру контейнера. Аналогично значению `Alignment(1.0, 0.0)`

* `Alignment.topCenter`: выравнивание по горизонтали по центру, по вертикали - у верхнего края контейнера (вверху по центру). Аналогично значению `Alignment(0.0, -1.0)`

* `Alignment.topLeft`: выравнивание по горизонтали по левому краю, по вертикали - у верхнего края контейнера (вверху слева). Аналогично значению `Alignment(-1.0, -1.0)`

* `Alignment.topRight`: выравнивание по горизонтали по правому краю, по вертикали - у верхнего края контейнера (вверху справа). Аналогично значению `Alignment(1.0, -1.0)`

Несмотря на то, что в конструкторе параметр `alignment` представляет класс `AlignmentGeometry`, здесь же константы представляют класс `Alignment`, который унаследован от `AlignmentGeometry`.

Используем виджет `Align` для размещения текста, к примеру, слева по центру:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Align(
    alignment: Alignment.centerLeft,
      child:Text(
      'Текст слева по центру!',
      textDirection: TextDirection.ltr,   // текст слева направо
      style: TextStyle(fontSize: 24) // высота шрифта 24
    )
  )
  );
}
```

![1](https://user-images.githubusercontent.com/83748388/234058114-73cd39c3-7a81-4db8-9bff-89f53d091436.png)

## `FractionalOffset`
Класс `FractionalOffset` унаследован от класса `Alignment` и предоставляет дополнительные 
возможности для позиционирования элемента. Он имеет следующий конструктор:

`FractionalOffset(double dx, double dy)`

где `dx` - это смещение по горизонтали, а `dy` - смещение по вертикали. 

Смещения выражаются в долях от `0.0` до `1.0`, например, `FractionalOffset(1.0, 0.0)` представляет верхний правый угол контейнера, а `FractionalOffset(0.0, 1.0)` - нижний левый угол. Соответственно `FractionalOffset(0.5, 0.5)` - это центр (как по горизонтали, так и по вертикали). Указав нужное смещение, мы можем расположить элемент в определенной части контейнера. Например:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Align(
      alignment: FractionalOffset(0.2, 0.3),
      child:Text(
      'Hello Flutter',
      textDirection: TextDirection.ltr,   // текст слева направо
        style: TextStyle(fontSize: 20) // высота шрифта 20
    )
   )
  );
}
```
Значение `FractionalOffset(0.2, 0.3)` указывает, что верхний угол вложенного элемента `Text` будет 
находиться по следующим координатам: `X` = ширина_контейнера_Align * 0.2, `Y` = 
высота_контейнера_Align * 0.3.


![2](https://user-images.githubusercontent.com/83748388/234058164-7225cc47-9377-4fc8-9730-71eb22479b54.png)

## `Center`
`Center` располагает вложенный элемент по центру. Он унаследован от класса `Align`, поэтому во многом перенимает у него функционал. По умолчанию он растягивается по всей ширине и высоте контейнера, заполняя все его пространство.

Для создания виджета применяется следующий конструктор:

`Center({Key key, double widthFactor, double heightFactor, Widget child})`

Для установки вложенного элемента, к которому будет применяться центрирование, используется 
параметр `child` - в его качестве может выступать любой объект `Widget`, то есть любой виджет.

Дополнительные параметры `widthFactor` и `heightFactor` устанавливают коэффициент изменения 
ширины и высоты виджета `Center` относительно вложенного дочернего элемента. Например, если 
`widthFactor` равен `2.0`, то ширина виджета `Center` будет равна ширине дочернего элемента, 
умноженной на `2.0`. То же самое касается и `heightFactor`, только он изменяет высоту.

Например, разместим по центру небольшой текст с использованием виджета `Center`:

```
import 'package:flutter/material.dart';

void main() {
  runApp(Center(
      child:Text(
      'Hello Flutter',
      textDirection: TextDirection.ltr,   // текст слева направо
    )
  )
  );
}
```

Фактически этот код будет равносилен следующему:

![3](https://user-images.githubusercontent.com/83748388/234058201-eda55745-d3f0-4065-a08d-8fa5ee66eb48.png)

```
import 'package:flutter/material.dart';

void main() {
  runApp(Align(
    alignment: Alignment.center,
      child:Text(
      'Hello Flutter!',
      textDirection: TextDirection.ltr
    )
  )
  );
}
```
## `Padding`
Виджет `Padding` позволяет задать отступы для вложенного элемента.

Он применяет следующий конструктор:

`Padding({Key key, @required EdgeInsetsGeometry padding, Widget child})`

Для установки отступов в конструкторе применяется параметр padding, который является обязательным параметром. Он представляет класс `EdgeInsetsGeometry`. Чтобы задать отступы, мы можем использовать один из конструкторов этого класса:

* `EdgeInsets.all(double value)`: устанавливает одно значение `double` для всех четырех отступов (слева, сверху, справа и снизу)

* `EdgeInsets.fromLTRB(double left, double top, double right, double bottom)`: устанавливает для каждой из четырех сторон свое значение отступ

* `EdgeInsets.fromWindowPadding(WindowPadding padding, double devicePixelRatio)`: определяет простанство, которое соответствует параметру `padding`

* `EdgeInsets.only({double left: 0.0, double top: 0.0, double right: 0.0, double bottom: 0.0})`: устанавливает для каждой из четырех сторон ненулевые значения отступов

* `EdgeInsets.symmetric({double vertical: 0.0, double horizontal: 0.0})`: `vertical` устанавливает верхний и нижний отступ, а `horizontal` - левый и правый.

Сначала рассмотрим пример, где не применяются отступы:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Align(
      alignment: Alignment.topCenter,
      child: Text(
        'Hello Flutter from metanit.com',
          textDirection: TextDirection.ltr
      )
    )
  );
}
```
Как видно, приложение занимает весь экран, в том числе верхнюю панель смартфона, где 
расположены различые индикаторы и текущее время.

Применим отступы, чтобы убрать тест в приложении не налазил на верхнюю панель смартфона:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Padding(
     padding: EdgeInsets.all(40),
      child: Align(
      alignment: Alignment.topCenter,
      child: Text(
        'Hello Flutter from metanit.com',
          textDirection: TextDirection.ltr
        )
      )
    )
  );
}
```
В данном случае контейнер `Align` с текстом помещен в другой контейнер - `Padding`. `Padding` устанавливает одно значение для всех четырех отступов - `40` единиц. В итоге текст в приложении будет смещен от верхней статусной панели на `40` единиц вниз:


С использованием других конструкторов `EdgeInsets` можно установить отступы для разных сторон. 

Например:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Padding(
     padding: EdgeInsets.only(top: 40, bottom:10, left:10, right:10),
      child: Align(
      alignment: Alignment.topCenter,
      child: Text(
        'Hello Flutter from metanit.com',
          textDirection: TextDirection.ltr
        )
      )
    )
  );
}
```
![4](https://user-images.githubusercontent.com/83748388/234058394-ebd742b7-4a0e-429d-8335-e6df8557abff.png)

Виджет `Padding` позволяет задать отступы для вложенного элемента.

Он применяет следующий конструктор:

`Padding({Key key, @required EdgeInsetsGeometry padding, Widget child})`

Для установки отступов в конструкторе применяется параметр `padding`, который является обязательным параметром. Он представляет класс `EdgeInsetsGeometry`. Чтобы задать отступы, мы можем использовать один из конструкторов этого класса:

* `EdgeInsets.all(double value)`: устанавливает одно значение `double` для всех четырех отступов (слева, сверху, справа и снизу)

* `EdgeInsets.fromLTRB(double left, double top, double right, double bottom)`: устанавливает для каждой из четырех сторон свое значение отступ

* `EdgeInsets.fromWindowPadding(WindowPadding padding, double devicePixelRatio)`: определяет простанство, которое соответствует параметру `padding`

* `EdgeInsets.only({double left: 0.0, double top: 0.0, double right: 0.0, double bottom: 0.0})`: устанавливает для каждой из четырех сторон ненулевые значения отступов

* `EdgeInsets.symmetric({double vertical: 0.0, double horizontal: 0.0})`: `vertical` устанавливает верхний и нижний отступ, а `horizontal` - левый и правый.

Сначала рассмотрим пример, где не применяются отступы:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Align(
      alignment: Alignment.topCenter,
      child: Text(
        'Hello Flutter from metanit.com',
          textDirection: TextDirection.ltr
      )
    )
  );
}
```
Как видно, приложение занимает весь экран, в том числе верхнюю панель смартфона, где расположены различые индикаторы и текущее время.

Применим отступы, чтобы убрать тест в приложении не налазил на верхнюю панель смартфона:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Padding(
     padding: EdgeInsets.all(40),
     child: Align(
        alignment: Alignment.topCenter,
        child: Text(
            'Hello Flutter from metanit.com',
            textDirection: TextDirection.ltr
        )
      ) 
    )
  );
}
```
В данном случае контейнер `Align` с текстом помещен в другой контейнер - `Padding`. `Padding` устанавливает одно значение для всех четырех отступов - `40` единиц. В итоге текст в приложении будет смещен от верхней статусной панели на `40` единиц вниз:

С использованием других конструкторов `EdgeInsets` можно установить отступы для разных сторон. 

Например:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Padding(
     padding: EdgeInsets.only(top: 40, bottom:10, left:10, right:10),
      child: Align(
      alignment: Alignment.topCenter,
      child: Text(
        'Hello Flutter from metanit.com',
          textDirection: TextDirection.ltr
        )
      )
    )
  );
}
 ```
![5](https://user-images.githubusercontent.com/83748388/234058296-5968205f-94b0-42be-ba8b-6132b59be828.png)

## `Container`
`Container` представляет такой виджет, который также может содержать только один вложенный элемент, но при этом предоставляет дополнительные возможности по настройке фона, позиционирования и размера вложенных виджетов. По сути `Container` объединяет возможности других виджетов - `Padding`, `Align`, `ConstrainedBox`.

Конструктор контейнера принимает довольно много параметров, которые позвляют настроить отдельные аспекты отображения:

```
Container({Key key, AlignmentGeometry alignment, EdgeInsetsGeometry padding, Color color, 
Decoration decoration, 

Decoration foregroundDecoration, double width, double height, BoxConstraints constraints, 
EdgeInsetsGeometry margin, 

Matrix4 transform, Widget child, Clip clipBehavior: Clip.none})
```

Рассмотрим некоторые параметры:

* `key`: ключ элемента

* `alignment`: настройки выравнивания вложенного элемента в виде объекта `AlignmentGeometry`, аналогично настройке выравнивания в виджете `Align`

* `padding`: настройки отступа вложенного элемента от границ контейнера, аналогично настройке отступов в виджете `Padding`

* `color`: цвет контейнера

* `constraints`: ограничения длины и ширины в виде объекта `BoxConstraints`, применяемые к вложенному виджету. Аналогично установке размеров в `ConstrainedBox`

* `margin`: устанавливает отступы текущего виджета `Container` от границ внешнего контейнера, аналогично настройке параметра `padding`

* `width`: ширина контейнера

* `heigt`: высота контейнера

Создадим простейший виджет `Container`:

```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Container(
      color: Colors.lightBlueAccent,
      alignment: Alignment.center,
      child: Text(
        'Hello Flutter from metanit.com',
          textDirection: TextDirection.ltr
        )
      )
  );
}
```
В данном случае в качестве цвета использован встроенный цвет (оттенок светло-синего цвета), описывамый значением `Colors.lightBlueAccent`. По выравниванию установлено центрирование вложенного виджета с помощью значения `Alignment.center`.

## Отступы `margin` и `padding`
Теперь рассмотрим применение отступов как для `margin`, так и для `padding`:
```
import 'package:flutter/material.dart';
 
void main() {
  runApp(Container(
      color: Colors.lightBlue,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(40),
      margin: EdgeInsets.only(top:30),
      child: Text(
        'Hello Flutter from metanit.com',
          textDirection: TextDirection.ltr
        )
      )
  );
}
```
В данном случае в качестве значения для `margin` установлен с верху отступ в `30` единиц. То есть виджет `Container` будет располагаться на `30` единиц ниже верхней границы экрана. Поэтому в верху экрана смартфона мы увидим черную полоску, которая не заполнена виджетом `Container`.

Также установлен отступ для вложенного виджета `Text` относительно границ `Container` в `40` единиц.

![6](https://user-images.githubusercontent.com/83748388/234058322-9ad5bdca-6fd8-420f-9855-ec0f92c1a4ae.png)



  
