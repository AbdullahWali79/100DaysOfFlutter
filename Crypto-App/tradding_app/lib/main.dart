import 'package:flutter/material.dart';
import 'package:tradding_app/Admin%20Pannel/add%20post.dart';
import 'package:tradding_app/User%20With%20Login%20Panel/loginscreen.dart';
import 'package:tradding_app/User%20Without%20Login%20Panel/show%20crpto.dart';

import 'Splash Screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Container(child: Text('Trading\n   App',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 60),),)),
          SizedBox(height: 50,),
          Center(child: GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin()));
    },child: Container(
            child: Center(
              child: Text('Admin',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),
              ),
            ),
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.green
          ),))),
          SizedBox(height: 40,),
          Center(child: GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
    },
    child: Container(
            child: Center(
              child: Text('User With Login',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),
              ),
            ),
            height: 50,
            width: 240,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue
            ),))),
          SizedBox(height: 40,),
          Center(child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowCryptoScreen()));
            },
              child:
              Container(
            child: Center(
              child: Text('User WithOut Login',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),
              ),
            ),
            height: 50,
            width: 270,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red
            ),))),
        ],
      ),
    );
  }
}
