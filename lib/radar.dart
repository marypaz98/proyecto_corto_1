library flutter_radar_chart;

import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

const defaultGraphColors = [
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.orange,
];

const defaultTicks = [1000, 10000, 100000,140000,180000];
const defaultFeatures = ["Intelectual", "Audición", "Mental", "Motora Superior",
  "Visión", "Movilidad"];
//var features = ["AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH"];
const totalData = [
  [23001, 37420,14126  , 64271, 112613, 19968, 16595],//hombres
  [25858 , 33469, 12845, 76109, 128851, 15448, 12818]//mujeres
];

const menData = [
  [23001, 37420,14126  , 64271, 112613, 19968, 16595]
];

const womenData = [
  [25858 , 33469, 12845, 76109, 128851, 15448, 12818]//mujeres
];

// ignore: must_be_immutable
class RadarChart extends StatefulWidget {
  final List<int> ticks;
  final List<String> features;
  List<List<int>> data;
  final bool reverseAxis;
  final TextStyle ticksTextStyle;
  final TextStyle featuresTextStyle;
  final Color outlineColor;
  final Color axisColor;
  final List<Color> graphColors;

  factory RadarChart.withSampleData() {

    return new RadarChart.light(ticks: defaultTicks,features: defaultFeatures, data: totalData);
  }

  RadarChart({
    Key key,
     this.ticks = defaultTicks,
     this.features = defaultFeatures,
     this.data = totalData,
    this.reverseAxis = false,
    this.ticksTextStyle = const TextStyle(color: Colors.black, fontSize: 12),
    this.featuresTextStyle = const TextStyle(color: Colors.black, fontSize: 16),
    this.outlineColor = Colors.black,
    this.axisColor = Colors.grey,
    this.graphColors = defaultGraphColors,
  }) : super(key: key);

  factory RadarChart.light({
    @required List<int> ticks,
    @required List<String> features,
    @required List<List<int>> data,
    bool reverseAxis = false,
  }) {
    return RadarChart(
      ticks: ticks,
      features: features,
      data: data,
      reverseAxis: reverseAxis,
    );
  }

  @override
  _RadarChartState createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChart> with SingleTickerProviderStateMixin {
  double fraction;
  Animation<double> animation;
  AnimationController animationController;
  String defaultValueForMenu = "Todos";
  List<List<int>> actualList = totalData;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: animationController,
    ))
      ..addListener(() {
        setState(() {
          fraction = animation.value;
        });
      });

    animationController.forward();
  }

  @override
  void didUpdateWidget(RadarChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    animationController.reset();
    animationController.forward();
  }

  Widget getForm(List<List<int>> dataList){
    return CustomPaint(
      size: Size(double.infinity,double.infinity),
      painter: RadarChartPainter(
          widget.ticks,
          widget.features,
          widget.data = dataList,
          widget.reverseAxis,
          widget.ticksTextStyle,
          widget.featuresTextStyle,
          widget.outlineColor,
          widget.axisColor,
          widget.graphColors,
          this.fraction),
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Discapacidad por género y tipo"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 4.0),
              child: Text(
                "Este grafico presenta la cantidad de personas con un determinado tipo de discapacidad por género, además de la comparación de las mismas entre ambos géneros.",
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Mostrando a:      ",style: TextStyle(fontSize: 15,),),
                  DropdownButton<String>(
                    value:this.defaultValueForMenu ,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String newValue) {
                      setState(() {
                        defaultValueForMenu = newValue;
                        if (defaultValueForMenu == "Hombres"){
                          actualList = menData;
                        }else if(defaultValueForMenu == "Mujeres"){
                          actualList = womenData;
                        }else{
                          actualList = totalData;
                        }
                      });
                    },
                    items: <String>["Todos", "Hombres", "Mujeres"].map((String value){
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList()
                  )
                ],
              ),
            ),
            Expanded(
              child: getForm(actualList)
            ),
          ],
        ),
      ),
    );

  }
}



class RadarChartPainter extends CustomPainter {
  final List<int> ticks;
  final List<String> features;
  final List<List<int>> data;
  final bool reverseAxis;
  final TextStyle ticksTextStyle;
  final TextStyle featuresTextStyle;
  final Color outlineColor;
  final Color axisColor;
  final List<Color> graphColors;
  final double fraction;

  RadarChartPainter(
      this.ticks,
      this.features,
      this.data,
      this.reverseAxis,
      this.ticksTextStyle,
      this.featuresTextStyle,
      this.outlineColor,
      this.axisColor,
      this.graphColors,
      this.fraction);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2.0;
    final centerY = size.height / 2.0;
    final centerOffset = Offset(centerX, centerY);
    final radius = math.min(centerX, centerY) * 0.8;
    final scale = radius / ticks.last;

    // Painting the chart outline
    var outlinePaint = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;

    var ticksPaint = Paint()
      ..color = axisColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    canvas.drawCircle(centerOffset, radius, outlinePaint);

    // Painting the circles and labels for the given ticks (could be auto-generated)
    // The last tick is ignored, since it overlaps with the feature label
    var tickDistance = radius / (ticks.length);
    var tickLabels = reverseAxis ? ticks.reversed.toList() : ticks;

    tickLabels.sublist(0, ticks.length - 1).asMap().forEach((index, tick) {
      var tickRadius = tickDistance * (index + 1);

      canvas.drawCircle(centerOffset, tickRadius, ticksPaint);

      TextPainter(
        text: TextSpan(text: tick.toString(), style: ticksTextStyle),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas,
            Offset(centerX, centerY - tickRadius - ticksTextStyle.fontSize));
    });

    // Painting the axis for each given feature
    var angle = (2 * pi) / features.length;

    features.asMap().forEach((index, feature) {
      var xAngle = cos(angle * index - pi / 2);
      var yAngle = sin(angle * index - pi / 2);

      var featureOffset =
      Offset(centerX + radius * xAngle, centerY + radius * yAngle);

      canvas.drawLine(centerOffset, featureOffset, ticksPaint);

      var featureLabelFontHeight = featuresTextStyle.fontSize;
      var featureLabelFontWidth = featuresTextStyle.fontSize-8;
      var labelYOffset = yAngle < 0 ? -featureLabelFontHeight : 0;
      var labelXOffset =
      xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

      TextPainter(
        text: TextSpan(text: feature, style: featuresTextStyle),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(
            canvas,
            Offset(featureOffset.dx + labelXOffset,
                featureOffset.dy + labelYOffset));
    });

    // Painting each graph
    data.asMap().forEach((index, graph) {
      var graphPaint = Paint()
        ..color = graphColors[index % graphColors.length].withOpacity(0.3)
        ..style = PaintingStyle.fill;

      var graphOutlinePaint = Paint()
        ..color = graphColors[index % graphColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..isAntiAlias = true;

      // Start the graph on the initial point
      var scaledPoint = scale * graph[0] * fraction;
      var path = Path();

      if (reverseAxis) {
        path.moveTo(centerX, centerY - (radius * fraction - scaledPoint));
      } else {
        path.moveTo(centerX, centerY - scaledPoint);
      }

      graph.asMap().forEach((index, point) {
        if (index == 0) return;

        var xAngle = cos(angle * index - pi / 2);
        var yAngle = sin(angle * index - pi / 2);
        var scaledPoint = scale * point * fraction;

        if (reverseAxis) {
          path.lineTo(centerX + (radius * fraction - scaledPoint) * xAngle,
              centerY + (radius * fraction - scaledPoint) * yAngle);
        } else {
          path.lineTo(
              centerX + scaledPoint * xAngle, centerY + scaledPoint * yAngle);
        }
      });

      path.close();
      canvas.drawPath(path, graphPaint);
      canvas.drawPath(path, graphOutlinePaint);
    });
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
