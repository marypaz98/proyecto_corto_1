import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_corto_1/bars.dart';
import 'package:proyecto_corto_1/pie.dart';
import 'package:proyecto_corto_1/bubble.dart';
import 'package:proyecto_corto_1/lineBar.dart';
import 'package:proyecto_corto_1/areaLine.dart';
import 'package:proyecto_corto_1/radar.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data viualization Project 1"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Hecho Por: "
                  "Mary Paz Aguilar y Juan José Solano",
                textAlign: TextAlign.justify,),
              decoration: BoxDecoration(
                color: Colors.lightBlue
              ),
            ),
            Divider(height:5,)
          ],
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: createButtons(context, Colors.cyan, [
            ["Bubble View", Bubble.withSampleData()],
            ["Line-Bar View",lineBar.withSampleData()],
            ["Radar View", RadarChart.withSampleData()]
          ])
        ),
      ),
    );
  }

  List<Widget> createButtons(BuildContext context, Color color ,List<dynamic> buttonsInfo){
    List<Widget> ret = new List<Widget>();
    for(List button in buttonsInfo){
      ret.add(FlatButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(button[0], textScaleFactor: 2, style: TextStyle(color: Colors.white),),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => button[1]));
        },
      )
      );
    }
    return ret;
  }
}
