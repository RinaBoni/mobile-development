/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTML Parsing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HtmlParsingDemo(),
    );
  }
}

class RandomNumber{
  late String number;
  late String time;

  RandomNumber({
    required this.number,
    required this.time,
  });
}

class HtmlParsingDemo extends StatefulWidget {
  @override
  _HtmlParsingDemoState createState() => _HtmlParsingDemoState();
}

class _HtmlParsingDemoState extends State<HtmlParsingDemo> {


  List<RandomNumber> randomNumbers = [];
  void initState(){
    super.initState();
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://randstuff.ru/number/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    
    final numbers = html
        .querySelectorAll('#number > span')
        .map((element) => element.innerHtml.trim())
        .toList();
    
    for (final number in numbers){
      debugPrint(number);
    }
    
    setState(() {
      randomNumbers = List.generate(numbers.length, (index) => RandomNumber(number: numbers[index], time: ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random number'),
      ),
      body:
      Container(
        margin: const EdgeInsets.all(30.0),
        width: double.infinity,
        child: ElevatedButton(
            child: const Text( 'Signup'),
            onPressed:(){
              getWebsiteData();
              ListView.builder(
                padding:  EdgeInsets.symmetric(
                    vertical: 50.0,
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                itemCount: randomNumbers.length,
                itemBuilder:(context, index){
                  final randomNumber = randomNumbers[index];
                  return ListTile(
                    title: Text(randomNumber.number),
                  );
                },
              );
            }
        ),
      ),

    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Number Graph',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomNumberGraph(),
    );
  }
}


class RandomNumber{
  late String number;
  late DateTime time;

  RandomNumber({
    required this.number,
    required this.time,
  });
}

class RandomNumberGraph extends StatefulWidget {
  @override
  _RandomNumberGraphState createState() => _RandomNumberGraphState();
}

class _RandomNumberGraphState extends State<RandomNumberGraph> {
  List<TimeSeriesSales> data = [];

  TextEditingController _controller = TextEditingController();
  String url = 'https://randstuff.ru/number/';

  void _getRandomNumber() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        data.add(TimeSeriesSales(DateTime.now(), jsonResponse['data']));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }



  List<RandomNumber> randomNumbers = [];
  void initState(){
  super.initState();
  getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://randstuff.ru/number/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final snumbers = html
        .querySelectorAll('#number > span')
        .map((element) => element.innerHtml.trim())
        .toString();
    //int? numbers = int.parse(snumbers.trim(), radix: 10);

    // for (final number in numbers){
    //   debugPrint(number);
    // }
    //var now = DateTime.now();


    setState(() {
      data.add(TimeSeriesSales(DateTime.now(), snumbers));
      print(snumbers);

      // randomNumbers = List.generate(numbers.length, (index) => RandomNumber(number: numbers[index], time: DateTime.now()));
      // print(randomNumbers.toString() );
      // randomNumbers.forEach((element) {print(element);});
      // var myList = [1, 2, 3, 4, 5];
      //
      // print(myList.toString());
    });
  }
  late TimeSeriesSales sales;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number Graph'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter URL',
              ),
              onChanged: (value) {
                setState(() {
                  url = value;
                });
              },
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed:(){ getWebsiteData; },
              child: Text(sales.number),
            ),
            SizedBox(height: 16.0),
            // Expanded(
            //   child: charts.TimeSeriesChart(
            //     [
            //       charts.Series<TimeSeriesSales, DateTime>(
            //         id: 'Random Number',
            //         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            //         domainFn: (TimeSeriesSales sales, _) => sales.time,
            //         measureFn: (TimeSeriesSales sales, _) => sales.number,
            //         data: data,
            //       ),
            //     ],
            //     animate: true,
            //     defaultRenderer: charts.LineRendererConfig(includePoints: true),
            //     dateTimeFactory: const charts.LocalDateTimeFactory(),
            //     primaryMeasureAxis: charts.NumericAxisSpec(
            //       tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final String number;

  TimeSeriesSales(this.time, this.number);
}