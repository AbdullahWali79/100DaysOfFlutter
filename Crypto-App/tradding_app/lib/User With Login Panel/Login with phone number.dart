

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button.dart';
class loginwithphonenumber extends StatefulWidget {
  const loginwithphonenumber({super.key});
  @override
  State<loginwithphonenumber> createState() => _loginwithphonenumberState();
}

class _loginwithphonenumberState extends State<loginwithphonenumber> {
  var   phonenumber=TextEditingController();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: phonenumber,
                    decoration: InputDecoration(
                        hintText: '+92 12343444356'
                    )
                ),
                SizedBox( height: 16,),
                roundedbutton(
                    loading: loading,
                    title: 'Send Code', onTap: (){
                  setState(() {loading=true;});
                })
              ],
            ),
          ),
        )
    );
  }
}
