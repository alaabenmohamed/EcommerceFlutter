// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataFromFireStore extends StatefulWidget {
  final String documentId;

  const GetDataFromFireStore({super.key, required this.documentId});

  @override
  State<GetDataFromFireStore> createState() => _GetDataFromFireStoreState();
}

class _GetDataFromFireStoreState extends State<GetDataFromFireStore> {
  final NommyController = TextEditingController();

  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('usersss');

  myDialog(Map data, dynamic keyy) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: NommyController,
                    maxLength: 20,
                    decoration: InputDecoration(hintText: "${data['$keyy']}")),
                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          users
                              .doc(credential!.uid)
                              .update({keyy: NommyController.text});
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 17),
                        )),
                    TextButton(
                        onPressed: () {
                          //addnewtask();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 17),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersss');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("User Name: ${data['username']}",
                      style: TextStyle(fontSize: 17)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'username');
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"username": FieldValue.delete()});
                            });
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email: ${data['email']}",
                      style: TextStyle(fontSize: 17)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'email');
                          },
                          icon: Icon(Icons.edit)),
                           IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"email": FieldValue.delete()});
                            });
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mot De Passe: ${data['pass']}",
                      style: TextStyle(fontSize: 17)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'pass');
                          },
                          icon: Icon(Icons.edit)),
                           IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"pass": FieldValue.delete()});
                            });
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Age: ${data['age']}", style: TextStyle(fontSize: 17)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'age');
                          },
                          icon: Icon(Icons.edit)),
                           IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"age": FieldValue.delete()});
                            });
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Titel: ${data['title']}",
                      style: TextStyle(fontSize: 17)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'title');
                          },
                          icon: Icon(Icons.edit)),
                       IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"title": FieldValue.delete()});
                            });
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
            SizedBox(
                height: 10,
              ),
               Center(
                 child: TextButton(onPressed: (){
                             setState(() {
                               users.doc(credential!.uid).delete();
                             });
               
                 }, child: Text("Supprimer Data", style: TextStyle(fontSize: 18),)),
               )
            
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
