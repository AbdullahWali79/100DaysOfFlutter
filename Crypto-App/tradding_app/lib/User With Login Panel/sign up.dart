


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button.dart';
import 'loginscreen.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  final _formkey=GlobalKey<FormState>();
  final email=TextEditingController();
  final password=TextEditingController();

  bool loading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Sign UP')),

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle,size: 50,),
              Form(
                  key:_formkey,
                  child:Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: email,
                        decoration: InputDecoration(
                          // label: Text('Email'),
                            hintText: 'Email',
                            // helperText: 'Enter email e.g join@gmail.com',
                            prefixIcon: Icon(Icons.email)

                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox( height: 16,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          //label: Text('password'),
                            hintText: 'Password',
                            //helperText: 'Enter password like 23451',
                            prefixIcon: Icon(Icons.password)
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ) ),
              SizedBox( height: 16,),
              roundedbutton(
                title: 'Sign Up',
                loading: loading,
                onTap: (){
                  if(_formkey.currentState!.validate()) {
                   ;
                  }
                },),
              SizedBox( height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return loginscreen();
                    },));
                  }, child: Text('Login'))
                ],
              )

            ],
          ),
        )
    );
  }
}
