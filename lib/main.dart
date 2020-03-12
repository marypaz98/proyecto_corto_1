import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_corto_1/bars.dart';
import 'package:proyecto_corto_1/pie.dart';
import 'package:proyecto_corto_1/bubble.dart';
import 'package:proyecto_corto_1/lineBar.dart';
import 'package:proyecto_corto_1/areaLine.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data viualization"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Drawer header"),
              decoration: BoxDecoration(
                color: Colors.lightBlue
              ),
            ),
            ListTile(
              title: Text("Option 1"),
              onTap: (){

              },
            ),
            Divider(height: 10,),
            ListTile(
              title: Text("Option 2"),
              onTap: (){

              },
            ),
            Divider(height: 10,),
            ListTile(
              title: Text("Option 3"),
              onTap: (){

              },
            ),
            Divider(height: 10,),
            ListTile(
              title: Text("Option 4"),
              onTap:(){

              },
            ),
            Divider(height: 10,),
            ListTile(
              title: Text("Option 5"),
              onTap: (){

              },
            ),
            Divider(height:10,)
          ],
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: createButtons(context, Colors.cyan, [
            ["Bars", Bars()],
            ["Pie", Pie()],
            ["Bubble", Bubble.withSampleData()],
            ["Line-Bar",lineBar.withSampleData()],
            ["Area-line", AreaLine.withSampleData()]
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
