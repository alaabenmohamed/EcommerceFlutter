// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/detailsPage.dart';
import 'package:flutter_application/pages/profile.dart';
import 'package:flutter_application/provider/cart.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';
import '../shared/appbar.dart';
import '../shared/colors.dart';
import '../shared/userImage.dart';
import 'checkout.dart';

// class Item {
//   String path ;
//   double prix ;
//   Item ({required this.path , required this.prix});
// }
class Home extends StatelessWidget {
  // const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/test.jpg"),
                          fit: BoxFit.cover),
                    ),
                    accountName: Text("Alaa Ben Mohamed ",
                    // accountName: Text(user.displayName!,

                        style: TextStyle(
                          //  color: Color.fromARGB(255, 255, 255, 255),
                          color: Colors.black,
                        )),
                    accountEmail: Text("alaa@yahoo.com"),
                    currentAccountPictureSize: Size.square(99),
                    currentAccountPicture: 
                    // ImgUser(),
                    CircleAvatar(
                        radius: 55,
                        //  backgroundImage:  NetworkImage(user.photoURL!),
                       backgroundImage: AssetImage("assets/img/alaa.jpg")
                       ),
                  ),
                  ListTile(
                      title: Text("Home"),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }),
                  ListTile(
                      title: Text("My products"),
                      leading: Icon(Icons.add_shopping_cart),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(),
                          ),
                        );
                      }),
                  ListTile(
                      title: Text("About"),
                      leading: Icon(Icons.help_center),
                      onTap: () {}),
                      ListTile(
                      title: Text("Profile Page"),
                      leading: Icon(Icons.person),
                      onTap: () {
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>    ProfilePage(),
                            
                          ),
                        );
                      }),
                  ListTile(
                      title: Text("Logout"),
                      leading: Icon(Icons.exit_to_app),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      }),
                ],
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("Develope par Alaa Ben Mohamed"))
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: reedd,
          title: Text("Home"),
          actions: [
            ProductsAndPrice(),
          ],
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //nbre ddes ellemnt sur X
                childAspectRatio: 3 / 2, //3 sur x et 2 sur y
                crossAxisSpacing: 10,

                /// desistance sur meme ligne x
                mainAxisSpacing: 33 //desistance sur meme ligne y

                ),
            itemCount: allImage.length,
            itemBuilder: (BuildContext context, int index) {
              //item builde : contient l'ellemt que sera repeter
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(produit: allImage[index]),
                    ),
                  );
                },
                child: GridTile(
                  child: Stack(children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          // child: Image.asset("${allImage[index]["path"]}")),
                          child: Image.asset(allImage[index].path)),
                    ),
                  ]),
                  footer: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GridTileBar(
                      backgroundColor: Color.fromARGB(50, 73, 127, 110),
                      trailing: Consumer<Cart>(
                          builder: ((context, classInstancee, child) {
                        return IconButton(
                            color: Color.fromARGB(255, 62, 94, 70),
                            onPressed: () {
                              classInstancee.add(allImage[index]);
                              //cart.add(allImage[index]);

                              classInstancee.prixcalcule(allImage[index]);
                            },
                            icon: Icon(Icons.add));
                      })),
                      leading: Text("\$${allImage[index].prix}"),
                      title: Text(
                        // il faut le laisse pour lespace
                        "",
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
