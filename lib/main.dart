// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/pages/VerfyEmail.dart';
import 'package:flutter_application/pages/checkout.dart';
import 'package:flutter_application/pages/detailsPage.dart';
import 'package:flutter_application/pages/home.dart';
import 'package:flutter_application/pages/login.dart';
import 'package:flutter_application/pages/register.dart';
import 'package:flutter_application/provider/cart.dart';
import 'package:flutter_application/provider/google_signin.dart';
import 'package:flutter_application/shared/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //  theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            }
          else  if (snapshot.hasData) {
              return Home();
            //  return VerifyEmailPage() ;
            } 
            else {
              return Login();
            }
          },
        ),
      ),
    );
  }
}
