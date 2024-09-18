import 'package:flutter/material.dart';
import 'package:tradding_app/User%20With%20Login%20Panel/sign%20up.dart';

import 'Login with phone number.dart';
import 'button.dart';
import 'forgot password.dart';
class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final email=TextEditingController();
  final password=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login & Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle,size: 50,),
            Form(
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
              title: 'Login',
              loading: loading,

              onTap: (){
                if(_formkey.currentState!.validate()){
                  ;
                }
              },),
            SizedBox( height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment:Alignment.bottomRight,
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return forgotpasswordscreen();
                    },));
                  }, child: Text('Forgot Password')),
                ),
              ],
            ),
            SizedBox( height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account?'),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Signup();
                  },));
                }, child: Text('Sign Up')),
              ],
            ),
            SizedBox( height: 16,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return loginwithphonenumber();
                },));
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: Colors.blue
                    )
                ),
                child: Center(child: Text('Login With Phone Number')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
