import 'package:flutter/material.dart';

enum MeasurementUnitList {mm, cm, m}

class MyCalulateArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCalulateAreaState();
}

class MyCalulateAreaState extends State<MyCalulateArea> {
  final _formKey = GlobalKey<FormState>();
  double _width = 25;
  double _height = 10;
  double _area = 0;
  MeasurementUnitList _measurementUnit = MeasurementUnitList.m;

  String printMeasurment(MeasurementUnitList _measurementUnit){
    try {
      switch(_measurementUnit){
        case MeasurementUnitList.mm:
          return 'мм';
        case MeasurementUnitList.m:
          return 'м';
        case MeasurementUnitList.cm:
          return 'см';
      }
    }catch (Exc) {
      print(Exc);
      rethrow;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: Column(
        children: [
          Row(children: <Widget>[
            Container(padding: EdgeInsets.all(10.0),child: Text('Выберите единицу измерения:')),
            Expanded(child: Container(padding:EdgeInsets.all(10.0),child:
            ListTile(
              title: const Text('милиметры'),
              leading: Radio<MeasurementUnitList>(
                  value: MeasurementUnitList.mm,
                  groupValue: _measurementUnit,
                  onChanged: (MeasurementUnitList? value) {
                    setState(() {
                      _measurementUnit = value!;
                    });
                  }
              ),
            ),
            ),),
            Expanded(child: Container(padding:EdgeInsets.all(10.0),child:
            ListTile(
              title: const Text('сантиметры'),
              leading: Radio<MeasurementUnitList>(
                  value: MeasurementUnitList.cm,
                  groupValue: _measurementUnit,
                  onChanged: (MeasurementUnitList? value) {
                    setState(() {
                      _measurementUnit = value!;
                    });
                  }
              ),
            ),
            ),),
            Expanded(child: Container(padding:EdgeInsets.all(10.0),child:
            ListTile(
              title: const Text('метры'),
              leading: Radio<MeasurementUnitList>(
                  value: MeasurementUnitList.m,
                  groupValue: _measurementUnit,
                  onChanged: (MeasurementUnitList? value) {
                    setState(() {
                      _measurementUnit = value!;
                    });
                  }
              ),
            ),
            ),),
          ],
          ),


          Row(children: <Widget>[
            Container(padding:EdgeInsets.all(10.0),child: Text('Ширина:')),
            Expanded(child: Container(padding:EdgeInsets.all(10.0),child:
            TextFormField(initialValue: '$_width',validator: (value){
              if (value!.isEmpty) return 'Задайте ширину';

              try {
                _width = double.parse(value);
              } catch(e) {
                _width = 0;
                return e.toString();
              }
            })
            )),
          ]
          ),

          //создаем контейнер для визуального разделения виджетов между собой по вертикали
          SizedBox(height: 10.0),

          Row(children: <Widget>[
            Container(padding:EdgeInsets.all(10.0),child: Text('Высота:')),
            Expanded(child: Container(padding:EdgeInsets.all(10.0),child:
            TextFormField(initialValue: '$_height',validator: (value){
              if (value!.isEmpty) return 'Задайте высоту';

              try {
                _height = double.parse(value);
              } catch(e) {
                _height = 0;
                return e.toString();
              }
            })
            )),
          ]
          ),

          SizedBox(height: 10.0),

          ElevatedButton(onPressed: (){
            if(_formKey.currentState!.validate()) {
              setState(() {
                if (_width is double && _height is double) _area = _width * _height;
              });
            }
          }, child: Text('Вычислить'), ),

          SizedBox(height: 50.0),

          Text(_area == null ? 'задайте параметры' : 'S = $_width * $_height = ${_area} ${printMeasurment(_measurementUnit)}', style: TextStyle(fontSize: 30.0),)
        ]
    ));
  }
}

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text('Калькулятор площади')),
            body: MyCalulateArea()
        )
    )
);