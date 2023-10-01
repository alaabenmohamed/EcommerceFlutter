// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/forgotpassword.dart';
import 'package:flutter_application/pages/register.dart';
import 'package:provider/provider.dart';

import '../provider/google_signin.dart';
import '../shared/colors.dart';
import '../shared/constants.dart';
import '../shared/custom_textfield.dart';
import '../shared/snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = true;
  final EmailmyController = TextEditingController();

  final PasswordmyController = TextEditingController();
  bool isLoading = false;
  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: EmailmyController.text,
        password: PasswordmyController.text,
      );
      // if (!mounted) return;
      // showSnackBar(context, "Conexions 👌 ");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "Erreur : ${e.code}");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    EmailmyController.dispose();
    PasswordmyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: reedd,
          title: Text("Login"),
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  // MyTextField(

                  //   textInputetypee: TextInputType.emailAddress,
                  //   isPassword: false,
                  //   hinttext: "Entrer votre Email :",
                  // ),
                  TextField(
                    controller: EmailmyController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorations.copyWith(
                      hintText: "Entrer votre Email :",
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                    controller: PasswordmyController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? true : false,
                    decoration: decorations.copyWith(
                        hintText: "Entrer Votre mot de passe :",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: isVisable
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility))),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await signIn();
                      if (!mounted) return;
                      // showSnackBar(context, "Conexions 👌 ");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(reedd),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "connexion",
                            style: TextStyle(fontSize: 19),
                          ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Forget()),
                        );
                      },
                      child: Text("mot de passe oublier ?",
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline))),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas un compte ?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text('Enregistrement',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 28)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 299,
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.6,
                        )),
                        Text(
                          "OR",
                          style: TextStyle(),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.6,
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 27),
                    child: GestureDetector(
                      onTap: () {
                        googleSignInProvider.googlelogin();
                      },
                      child: Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                // color: Colors.purple,
                                color: Color.fromARGB(255, 200, 67, 79),
                                width: 1)),
                        child: SvgPicture.asset(
                          "assets/icons/google.svg",
                          color: Color.fromARGB(255, 200, 67, 79),
                          height: 27,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





