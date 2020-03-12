/// Scatter plot chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  Bubble(this.seriesList, {this.animate});

  /// Creates a [ScatterPlotChart] with sample data and no transition.
  factory Bubble.withSampleData() {
    return new Bubble(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.ScatterPlotChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5, 20),
      new LinearSales(10, 25, 14),
      new LinearSales(12, 75, 15),
      new LinearSales(13, 225, 17),
      new LinearSales(16, 50, 18),
      new LinearSales(24, 75, 23),
      new LinearSales(25, 100, 14),
      new LinearSales(34, 150, 15),
      new LinearSales(37, 10, 14),
      new LinearSales(45, 300, 18),
      new LinearSales(52, 15, 14),
      new LinearSales(56, 200, 17),
    ];

    final maxMeasure = 300;

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        // Providing a color function is optional.
        colorFn: (LinearSales sales, _) {
          // Bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        // Providing a radius function is optional.
        radiusPxFn: (LinearSales sales, _) => sales.radius,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final double radius;

  LinearSales(this.year, this.sales, this.radius);
}
