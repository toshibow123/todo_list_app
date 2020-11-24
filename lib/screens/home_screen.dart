import 'package:flutter/material.dart';
import 'package:todo_list_app/parts/button_with_icon.dart';
import 'package:todo_list_app/screens/word_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset("assets/images/aaa.jpg")),
            _titleText(),
            Divider(
              height: 100.0,
              color: Colors.white,
            ),
            //TODO 確認テスト
            ButtonWithIcon(
              onPressed: () => _startWordListScreen(context),
              icon: Icon(Icons.play_arrow),
              label: "Todoの確認",
              color: Colors.blueGrey,
            ),
            SizedBox(height: 100.0,),
            Text(
                "powerd by honyarara")
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return Column(
      children: <Widget>[
        ShaderMask(
    shaderCallback: (Rect bounds) {
      return RadialGradient(
        center: Alignment.topLeft,
        radius: 1.0,
        colors: <Color>[Colors.grey, Colors.white],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
    child: Text("ただのTodoアプリ", style: TextStyle(fontSize: 40.0),)
    ),
        ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: <Color>[Colors.white, Colors.deepOrange.shade900],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: Text("Normal Todo App", style: TextStyle(fontSize: 24.0),),
    ),
      ],
    );
  }
  _startWordListScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WordListScreen()));
  }
}
