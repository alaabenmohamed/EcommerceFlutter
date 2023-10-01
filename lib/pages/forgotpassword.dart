// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/login.dart';
import 'package:flutter_application/shared/colors.dart';

import '../shared/constants.dart';
import '../shared/snackbar.dart';

class Forget extends StatefulWidget {
  Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final EmailmyController = TextEditingController();

resetpassword() async{
   showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
try {
  await FirebaseAuth.instance
          .sendPasswordResetEmail(email: EmailmyController.text);
        if (!mounted) return;
        showSnackBar(context, " 👍 Check your Email");
      //  Navigator.pushReplacement(context, MaterialPageRoute (builder : (context)=> Login()));
 
}  on FirebaseAuthException catch (e) {
   showSnackBar(context, "Erreur : ${e.code}");
}
//stop showdialog
if (!mounted) return;
   // Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
}

  @override
void dispose() {
    EmailmyController.dispose();
  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mot de passe oublier"),
        elevation : 0 ,
        // backgroundColor: appbarGreen ,
        backgroundColor: reedd,

      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Entrer votre email pour réinitialiser le mot de passe  "),
             const SizedBox(
                          height: 33,
                        ),
              TextFormField(
                            validator: (value) {
                              return value!.contains(RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                  ? null
                                  : "Entrer a valid email";
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: EmailmyController,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: decorations.copyWith(
                                hintText: "Entrer votre Email :",
                                suffixIcon: Icon(Icons.email))),
                  
                        const SizedBox(
                          height: 33,
                        ),
                           ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      resetpassword();
                    //   // await register();
                    //   if (!mounted) return;
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>
                    //      Login()
                    //      ),
                    //   );
                    } else {
                      showSnackBar(context, 'Erreur De Champs');
                    }
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
                          "Reinitialiser le mot de passe",
                          style: TextStyle(fontSize: 19),
                        ),
                ),
                    
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}