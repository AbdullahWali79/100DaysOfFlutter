
import 'package:flutter/material.dart';

import 'button.dart';
class forgotpasswordscreen extends StatefulWidget {
  const forgotpasswordscreen({super.key});

  @override
  State<forgotpasswordscreen> createState() => _forgotpasswordscreenState();
}

class _forgotpasswordscreenState extends State<forgotpasswordscreen> {
  final emailcon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailcon,
                decoration: InputDecoration(
                    hintText: 'Enter Email'
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          roundedbutton(title: 'Forgot', onTap: (){


          })
        ],
      ),
    );
  }
}
