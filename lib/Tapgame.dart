import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'choicemenu.dart';
import 'timer.dart';

class Tapgame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<Tapgame> {
  List<Offset> _circles = [];
  int _point = 0;
  MyTimer? myTimer;

  @override
  void initState() {
    super.initState();
    myTimer = MyTimer();
    myTimer!.setOnUpdate(() {
      setState(() {});
      _addCircle();
    });

    myTimer!.start();
  }

  @override
  void dispose(){
    super.dispose();
    _showDialog();
  }


  void _addCircle() {
    Random random = Random();
    double x = random.nextDouble() * MediaQuery.of(context).size.width;
    double y = random.nextDouble() * (MediaQuery.of(context).size.height - AppBar().preferredSize.height);
    _circles.add(Offset(x, y));
    if (myTimer!.seconds < 15) {
      x = random.nextDouble() * MediaQuery.of(context).size.width;
      y = random.nextDouble() * (MediaQuery.of(context).size.height - AppBar().preferredSize.height);
      _circles.add(Offset(x, y));
    }
    if (myTimer!.seconds < 5) {
      x = random.nextDouble() * MediaQuery.of(context).size.width;
      y = random.nextDouble() * (MediaQuery.of(context).size.height - AppBar().preferredSize.height);
      _circles.add(Offset(x, y));
    }

    if (myTimer!.seconds < 0){
      _showDialog();
      myTimer!.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tapgame', style: TextStyle(fontSize: 15)),
              SizedBox(width: 10),
              Text('残り時間${myTimer!.seconds}', style: TextStyle(fontSize: 15)),
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
        body: Stack(
          children: [
            ..._circles.map(
              (circle) => Positioned(
                left: circle.dx,
                top: circle.dy,
                child: GestureDetector(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _point++;
                      _circles.remove(circle);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
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

                if(yourList[0]['result'] < _point){

                  yourList[0]['result'] = _point;

                  if(_point > 10){
                    yourList[0]['icon'] = 2;
                  }else if(_point > 20){
                    yourList[0]['icon'] = 3;
                  }else if(_point > 30){
                    yourList[0]['icon'] = 4;
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