// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sort_child_properties_last, avoid_print

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/login.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';
import '../shared/custom_textfield.dart';
import '../shared/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename;
class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  File? imgPath;
  String? imgName;
  final EmailmyController = TextEditingController();

  final PasswordmyController = TextEditingController();
  final TitelmyController = TextEditingController();
  final AgemyController = TextEditingController();
  final NommyController = TextEditingController();

// bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
//   bool hasDigits = password.contains(RegExp(r'[0-9]'));
//   bool hasLowercase = password.contains(RegExp(r'[a-z]'));
//   bool hasSpecialCharacters =
//       password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
//   bool hasMin8Characters = password.contains(RegExp(r'.{8,}'));
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasMin8Characters = false;
  bool hasSpecialCharacters = false;

  uploadImage() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
                imgName = basename(pickedImg.path);
                 int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
                print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  onPasswordChanged(String password) {
    hasDigits = false;
    hasLowercase = false;
    hasUppercase = false;
    hasMin8Characters = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{6,}'))) {
        hasMin8Characters = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        hasDigits = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailmyController.text,
        password: PasswordmyController.text,
      );
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("Image/$imgName");
      await storageRef.putFile(imgPath!);
      String url = await storageRef.getDownloadURL();
      print(credential.user!.uid);
      CollectionReference users =
          FirebaseFirestore.instance.collection('usersss');

      users
          .doc(credential.user!.uid)
          .set({
            'imgLink': url ,
            'username': NommyController.text,
            'age': AgemyController.text,
            'title': TitelmyController.text,
            'email': EmailmyController.text,
            'pass': PasswordmyController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'Le mot de passe fourni est trop faible.');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(

        //   duration: Duration(days: 1),
        //   content: Text('The password provided is too weak.'),
        //   action: SnackBarAction(label: "close", onPressed: () {}),
        // ));

        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'Un compte existe deja avec cette email.');
      } else {
        showSnackBar(context, "Ereur - s'il vous plait essayer à nouveau");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    EmailmyController.dispose();
    PasswordmyController.dispose();
    NommyController.dispose();
    AgemyController.dispose();
    TitelmyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registrer"),
          elevation: 0,
          // backgroundColor: appbarGreen ,
          backgroundColor: reedd,
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110),
                      ),
                      child: Stack(children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 225, 225, 225),
                                radius: 71,
                                // backgroundImage: AssetImage("assets/img/avatar.png"),
                                backgroundImage:
                                    AssetImage("assets/img/avatar.png"),
                              )
                            : ClipOval(
                                child: Image.file(
                                  imgPath!,
                                  width: 145,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 95,
                          child: IconButton(
                            onPressed: () {
                              uploadImage();
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: Color.fromARGB(255, 94, 115, 128),
                          ),
                        ),
                      ]),
                    ),

                    const SizedBox(
                      height: 64,
                    ),
                    TextField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        controller: NommyController,
                        decoration: decorations.copyWith(
                            hintText: "Entrer Votre Nom :",
                            suffixIcon: Icon(Icons.person))),

                    const SizedBox(
                      height: 33,
                    ),
                    // MyTextField(

                    //   textInputetypee: TextInputType.emailAddress,
                    //   isPassword: false,
                    //   hinttext: "Entrer votre Email :",
                    // ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        controller: AgemyController,
                        decoration: decorations.copyWith(
                            hintText: "Enter Your age : ",
                            suffixIcon: Icon(Icons.pest_control_rodent))),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        controller: TitelmyController,
                        decoration: decorations.copyWith(
                            hintText: "Enter Your title : ",
                            suffixIcon: Icon(Icons.person_outline))),
                    const SizedBox(
                      height: 22,
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
                    TextFormField(
                        onChanged: (value) {
                          onPasswordChanged(value);
                        },
                        validator: (value) {
                          return value!.length < 6
                              ? "Entrer au moins 6 caractères"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    : Icon(Icons.visibility)))),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasMin8Characters
                                  ? Colors.green
                                  : Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 189, 189, 189))),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("au moins 6 caractère")
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasDigits ? Colors.green : Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 189, 189, 189))),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("au moins un nombre")
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasUppercase ? Colors.green : Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 189, 189, 189))),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Au moins un majescule")
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasLowercase ? Colors.green : Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 189, 189, 189))),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("au moins un miniscule")
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasSpecialCharacters
                                  ? Colors.green
                                  : Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 189, 189, 189))),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("un caractère spéciale")
                      ],
                    ),

                    const SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()
                        // && imgName != null 
                        ) {
                          await register();
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
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
                      // child: Text(
                      //   "Enregistrer",
                      //   style: TextStyle(fontSize: 19),
                      // ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Enregistrer",
                              style: TextStyle(fontSize: 19),
                            ),
                    ),

                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vous avez  un compte ?",
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 28)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
