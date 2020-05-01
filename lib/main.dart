import 'package:flutter/material.dart';
import 'package:memorygame/data/data.dart';
import 'package:memorygame/module/tile_module.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<TileModel> pairs = new List<TileModel>();
  List<TileModel> visiblePairs = new List<TileModel>();

  @override
  void initState(){
    super.initState();
    pairs = getPairs();
    pairs.shuffle();
    visiblePairs = pairs;
    select=true;
    Future.delayed(const Duration(seconds: 5),(){
        setState(() {
          visiblePairs = getQuestions();
          select=false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Text("$points/800",style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),),
            Text("Points"),
            SizedBox(height:20 ,),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 0.0,
                maxCrossAxisExtent: 100),
                children: List.generate(pairs.length,(index){
                  return Tile(
                    imageAssetPath: pairs[index].getImageAssetPath(),
                    selected: pairs[index].getIsSelected(),
                    parent: this,
                    );
                })    
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {

  String imageAssetPath;
  bool selected;
  _HomePageState parent;
  Tile({this.imageAssetPath,this.selected,this.parent});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!select){
          print("You clicked");
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Image.asset(widget.imageAssetPath),
      ),
    );
  }
}