import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class Zoompintgame extends StatefulWidget {
  const Zoompintgame({Key? key}) : super(key: key);

  @override
  _ZoompintgameState createState() => _ZoompintgameState();
}

class  _ZoompintgameState extends State<Zoompintgame>{
  int success = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Zoompintgame')),
      body: Center(
        child: InteractiveViewer(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              child: Icon(Icons.flutter_dash),
            ),
          ),
        ),
      ),
    );
  }
}