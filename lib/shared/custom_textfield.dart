


import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // const MyTextField({super.key});
  final  bool isPassword ;
  final  TextInputType  textInputetypee ;
  final  String hinttext ;
 MyTextField({super.key, required this.hinttext ,required this.isPassword ,required this.textInputetypee ,}) ;
  @override
  Widget build(BuildContext context) {
    return  TextField(
                  keyboardType: textInputetypee,
                 obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: hinttext,
                    // To delete borders
                    enabledBorder: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(context),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    // fillColor: Colors.red,
                    filled: true, // couleur ramadi
                    contentPadding: const EdgeInsets.all(8),
                  ));
  }
}

