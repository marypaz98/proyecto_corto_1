/// Example of a scatter plot chart with a bucketing measure axis and a legend.
///
/// A bucketing measure axis positions all values beneath a certain threshold
/// into a reserved space on the axis range. The label for the bucket line will
/// be drawn in the middle of the bucket range, rather than aligned with the
/// gridline for that value's position on the scale.
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

    var chart= new charts.ScatterPlotChart(seriesList,
        // Set up a bucketing axis that will place all values below 0.1 (10%)
        // into a bucket at the bottom of the chart.
        //
        // Configure a tick count of 3 so that we get 100%, 50%, and the
        // threshold.
        primaryMeasureAxis: new charts.BucketingAxisSpec(
            threshold: 0.1,
            tickProviderSpec: new charts.BucketingNumericTickProviderSpec(
                desiredTickCount: 3)),
        // Add a series legend to display the series names.
        behaviors: [
          new charts.SeriesLegend(position: charts.BehaviorPosition.end),
        ],
        animate: animate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bubble"),
        centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 200.0,
              child: chart,
            ),
          ),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final adolescentes = [
      new LinearSales(14, 0.07, 15.0),
    ];

    final jovenes = [
      new LinearSales(29, 0.22, 20.0),
    ];

    final adultos = [
      new LinearSales(64, 0.52, 30.0),
    ];

    final adultosMayores = [
      new LinearSales(95, 0.33, 25.0),
    ];


    return [
      new charts.Series<LinearSales, int>(
          id: 'Adolescentes',
          colorFn: (LinearSales sales, _) =>
          charts.MaterialPalette.blue.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: adolescentes),
      new charts.Series<LinearSales, int>(
          id: 'Jovenes',
          colorFn: (LinearSales sales, _) =>
          charts.MaterialPalette.red.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: jovenes),
      new charts.Series<LinearSales, int>(
          id: 'Adultos',
          colorFn: (LinearSales sales, _) =>
          charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: adultos),
      new charts.Series<LinearSales, int>(
          id: 'Adultos Mayores',
          colorFn: (LinearSales sales, _) =>
          charts.MaterialPalette.purple.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: adultosMayores),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final double revenueShare;
  final double radius;

  LinearSales(this.year, this.revenueShare, this.radius);
}