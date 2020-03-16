/// Example of a numeric combo chart with two series rendered as bars, and a
/// third rendered as a line.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';



class lineBar extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  lineBar(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory lineBar.withSampleData() {
    return new lineBar(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    var chart= new charts.NumericComboChart(seriesList,
        animate: animate,
        // Configure the default renderer as a line renderer. This will be used
        // for any series that does not define a rendererIdKey.
        defaultRenderer: new charts.LineRendererConfig(),
        // Custom renderer configuration for the bar series.
        customSeriesRenderers: [
          new charts.BarRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'customBar')
        ],
        behaviors: [
        new charts.SeriesLegend(position: charts.BehaviorPosition.end),
    ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Line bar"),
        centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Discapacidad para oir según el genero',
          ),
          //new Text(
          //  '${clicksCount[actualClickData]}',
          // style: Theme.of(context).textTheme.display1,
          // ),
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
  static List<charts.Series<discapacityData, int>> _createSampleData() {
    final womenData = [
      new discapacityData(9, 579),
      new discapacityData(19, 1561),
      new discapacityData(29, 1533),
      new discapacityData(39, 1997),
      new discapacityData(49, 3404),
      new discapacityData(59, 4515),
      new discapacityData(69, 5192),
      new discapacityData(79, 6160),
      new discapacityData(99, 8428),
    ];

    final menData = [
      new discapacityData(9, 888),
      new discapacityData(19, 1814),
      new discapacityData(29, 1847),
      new discapacityData(39, 2262),
      new discapacityData(49, 3635),
      new discapacityData(59, 4830),
      new discapacityData(69, 6375),
      new discapacityData(79, 7591),
      new discapacityData(99, 7998),
    ];



    return [
      new charts.Series<discapacityData, int>(
        id: 'Mujeres',
        colorFn: (discapacityData_, _sales_) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (discapacityData sales, _) => sales.age,
        measureFn: (discapacityData sales, _) => sales.discapacity,
        data: womenData,
      )
      // Configure our custom bar renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customBar'),
      new charts.Series<discapacityData, int>(
        id: 'Hombres',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (discapacityData sales, _) => sales.age,
        measureFn: (discapacityData sales, _) => sales.discapacity,
        data: menData,
      ),
    ];
  }
}

/// Sample linear data type.
class discapacityData {
  final int age;
  final int discapacity;

  discapacityData(this.age, this.discapacity);
}