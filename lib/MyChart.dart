import 'package:flutter/material.dart';
import 'MySeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//Esta clase es una abstraccion de alto nivel de una grafica de barras
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
    //Retorna el container con la grafica
    return Container(
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
