import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import 'package:rennsyuuapp/Scrollgame.dart';
import 'package:rennsyuuapp/timer.dart';
import 'main.dart';
import 'choicemenu.dart';
import 'dart:math';

class Swipegame extends StatefulWidget {
  const Swipegame({Key? key}) : super(key: key);

  @override
  _SwipegameState createState() => _SwipegameState();
}

class _SwipegameState extends State<Swipegame> with SingleTickerProviderStateMixin{
  int score = 0;
  MyTimer? myTimer;
  final contents = List.generate(9, (index) => index + 1);
  String _convertContainer(int number) => List.generate(number, (index) => '$number').join('');
  int Swipe_Point_Number = randomIndex(10) + 1;

  @override
  void initState(){
    super.initState();

    // Timer処理の呪文 下
    myTimer = MyTimer();
    myTimer!.setOnUpdate((){
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
            Text('得点は$score点です', style: TextStyle(fontSize: 15))
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () { _showDialog(); },
          ),
        ],
      ),
      body: InfiniteScrollTabView(
        contentLength: contents.length,
        onPageChanged: (index) => {
          Update_Setting_Number(index)
        },
        tabBuilder: (index, isSelected) => Text(
          "${index + 1}",
          style: TextStyle(
            color: isSelected ? Colors.pink : Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),

        pageBuilder: (context, index, _) {
          return SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(contents[index] / 10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "今は${index + 1}にいます",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: contents[index] / 10 > 0.6
                          ? Colors.white
                          : Colors.black87,
                        fontSize: 42
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "次は${Swipe_Point_Number}に向かってください",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: contents[index] / 10 > 0.6
                          ? Colors.white
                          : Colors.black87,
                        fontSize: 30
                      ),
                    )
                  ]
                )
              ),
            ),
          );
        }
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('終了'),
          content: Text('貴方の点数は $score点です'),
          actions: [
            TextButton(
              child: Text('最初に戻る'),
              onPressed: () {
                if(yourList[2]['result'] < score){
                  yourList[2]['result'] = score;
                  if(score > 6){
                    yourList[2]['icon'] = 2;
                  }else if(score > 10){
                    yourList[2]['icon'] = 3;
                  }else if(score > 18){
                    yourList[2]['icon'] = 4;
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
  void Update_Setting_Number(int index){
    int Check_Random_Number;
    if (index == (Swipe_Point_Number-1)){
      setState(() {
        score++;
        Check_Random_Number = Swipe_Point_Number;
        Swipe_Point_Number = randomIndex(9) + 1;
        if (Check_Random_Number == Swipe_Point_Number){
          Update_Setting_Number(index);
        }
      });
    }
  }
}