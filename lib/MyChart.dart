import 'package:flutter/material.dart';
import 'MySeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyBarChart extends StatelessWidget {
  final List<MySeries> data;

  MyBarChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<MySeries, String>> series = [
      charts.Series(
        id: "Ejercicios de la semana",
        data: data,
        domainFn: (MySeries series, _) => series.category,
        measureFn: (MySeries series, _) => series.number,
        colorFn: (MySeries series, _) => series.color,
        measureUpperBoundFn: (MySeries series, _) => 15,
        measureLowerBoundFn: (MySeries series, _) => 0,
      ),
    ];

    BoxShadow boxShadow2 = BoxShadow(
      color: Colors.black54, blurRadius: 10.0, offset: Offset(1.75, 1.75));

    return Container(
        //decoration: BoxDecoration(boxShadow: [boxShadow2]),
        height: 300,
        margin: EdgeInsets.all(10.0),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Text("Ejercicios Semanales"),
              Expanded(child: charts.BarChart(series, animate: true)),
            ],
          ),
        )));
  }
}
