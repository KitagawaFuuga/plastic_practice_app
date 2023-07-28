import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rennsyuuapp/timer.dart';
import 'dart:math';
import 'choicemenu.dart';
import 'timer.dart';

class Scrollgame extends StatefulWidget {
  const Scrollgame({Key? key}) : super(key: key);

  @override
  _ScrollgameState createState() => _ScrollgameState();
}

int randomIndex(int max) {
  final random = Random();
  return random.nextInt(max);
}

class _ScrollgameState extends State<Scrollgame>{
  int check = 0, _point = 0;
  int _randomIndex = randomIndex(51); // 最初にランダムなインデックス番号を生成
  MyTimer? myTimer;

  @override
  void initState(){
    super.initState();
    myTimer = MyTimer();
    myTimer!.setOnUpdate(() { 
      setState(() {}); 

      if(myTimer!.seconds < 0){
        _showDialog();
        myTimer!.stop();
      }
    });
    myTimer!.start();
  }

  @override
  void dispose(){
    super.dispose();
    _showDialog();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Scrollgame', style: TextStyle(fontSize: 15)),
            SizedBox(width: 10),
            Text('残り時間は${myTimer!.seconds}', style: TextStyle(fontSize: 15)),
            SizedBox(width: 10),
            Text('得点は$_point点です', style: TextStyle(fontSize: 15))
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              _showDialog();
            },
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 51,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                setState(() {
                  if(index == _randomIndex){
                    _point++;
                    _randomIndex = randomIndex(51);
                    if(_randomIndex < index + 10 ||_randomIndex > index - 10){

                      if(_randomIndex < 25)
                        _randomIndex += 10;

                      else if(_randomIndex > 25)
                        _randomIndex -= 10;

                    }
                  } 
                });
              },
              child: Container(
                child: Column(
                  children: [
                    index == _randomIndex ? ListTile(title: Text('Tile $index'),tileColor: Colors.red) : ListTile(title: Text('Tile $index')),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      height: 1,
                    )
                  ]
                )
              )
            );
          },
        )
      ),
    );
  }
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('終了'),
          content: Text('貴方の点数は $_point 点です'),
          actions: [
            TextButton(
              child: Text('最初に戻る'),
              onPressed: () {

                if(yourList[1]['result'] < _point){

                  yourList[1]['result'] = _point;

                  if(_point > 8){
                    yourList[1]['icon'] = 2;
                  }else if(_point > 11){
                    yourList[1]['icon'] = 3;
                  }else if(_point > 17){
                    yourList[1]['icon'] = 4;
                  }
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChoiceMenu()),
                );
                
              }
            ),
          ],
        );
      },
    );
  }
}