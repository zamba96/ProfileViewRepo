import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

//Esta clase representa un dato para una grafica
class MySeries {
  final String category;
  final int number;
  final charts.Color color;

  final int size = 2;

  MySeries({
    @required this.category,
    @required this.number,
    @required this.color
  });

}