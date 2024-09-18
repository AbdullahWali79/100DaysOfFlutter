import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tradding_app/main.dart';
class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 5),
            (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return MyHomePage();
          }),);
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child:Image.asset('asset/trading.png'),

            ),
        ],
      ),
    );
  }
}

