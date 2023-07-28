import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Tapgame.dart';
import 'Scrollgame.dart';
import 'Swipegame.dart';
import 'Zoompintgame.dart';

List<Map<String, dynamic>> yourList = [
  {"title": "タップ", "result": 0, "icon": 1, "screen" : Tapgame()},
  {"title": "スクロール","result": 0, "icon": 1,"screen" : Scrollgame()},
  {"title": "スワイプ", "result": 0, "icon": 1,"screen" : Swipegame()},
  {"title": "ズームとピント", "result": 0, "icon": 1,"screen" : Zoompintgame()},
];

class ChoiceMenu extends StatefulWidget {
  const ChoiceMenu({Key? key}) : super(key: key);

  @override
  _ChoiceMenuState createState() => _ChoiceMenuState();
}

class _ChoiceMenuState extends State<ChoiceMenu>{
  int success = 0;

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            '貴方は${yourList.length}個中${success.toString()}個成功しました'
          ),
        ),
      ),
      body: Center(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index){
            return const Divider(
              color: Colors.black,
              thickness: 1,
              height: 1,
            );
          },
          itemCount: yourList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(yourList[index]['title']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${yourList[index]['result']}"),
                  SizedBox(width: width * 0.05),
                  Icon(Icons.circle, color: colordIcon(yourList[index]['icon'])),
                  SizedBox(width: width * 0.03)
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => yourList[index]['screen'],
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }

  Color colordIcon(int value){
    Color color = Colors.black;
    switch(value){ 
      case 1: color = Colors.red; break;
      case 2: color = Colors.yellow; break;
      case 3: color = Colors.blue; break;
      case 4: color = Colors.green; break;
    }
    return color;
  }
}

