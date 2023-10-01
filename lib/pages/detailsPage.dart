// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';
import '../provider/cart.dart';
import '../shared/appbar.dart';
import '../shared/colors.dart';

class Details extends StatefulWidget {
  Item produit;
  Details({required this.produit});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // const Details({super.key});
  bool isShowmore = false;

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: reedd,
        // title: Text("Details Page"),
        title: Text("Details Page"),

        actions: [
            ProductsAndPrice(),
          // Row(
          //   children: [
          //     Stack(
          //       children: [
          //         IconButton(
          //             onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
          //         Positioned(
          //           //  bottom: 18,
          //           child: Container(
          //               child:
          //               //  Consumer<Cart>(
          //               //     builder: ((context, classInstancee, child) {
          //               //   return 
          //                 Text(
          //                   ("${classInstancee.selectProduit.length}"),
          //                   style:
          //                       TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //                 ),
          //               // })),
          //               padding: EdgeInsets.all(5),
          //               decoration: BoxDecoration(
          //                   color: Color.fromARGB(211, 164, 255, 193),
          //                   shape: BoxShape.circle)),
          //         ),
          //       ],
          //     ),
          //     Padding(
          //         padding: const EdgeInsets.only(right: 12),
          //         child:
                  
          //         //  Consumer<Cart>(
          //         //     builder: ((context, classInstancee, child) {
          //           // return 
          //           Text("\$${classInstancee.prixTotale}"),
          //         // }))
          //         )
          //   ],
          // )
        
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 11,
            ),
            Image.asset(widget.produit.path),
            SizedBox(
              height: 11,
            ),
            Text(
              "\$ ${widget.produit.prix}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    "New",
                    style: TextStyle(fontSize: 15),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 129, 129),
                      borderRadius: BorderRadius.circular(4)),
                ),
                SizedBox(
                  width: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Colors.amber,
                    ),
                  ],
                ),
                SizedBox(
                  width: 66,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.edit_location,
                      size: 26,
                      color: Color.fromARGB(168, 3, 65, 27),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.produit.location,
                      style: TextStyle(fontSize: 19),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Détails :",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "La pizza est une recette de cuisine traditionnelle de la cuisine italienne, originaire de Naples à base de galette de pâte à pain, garnie principalement d'huile d'olive, de sauce tomate, de mozzarella et d'autres ingrédients1 et cuite au four. Plat emblématique de la culture italienne, et de la restauration rapide dans le monde entier, elle est déclinée sous de multiples variantes. « L'art de fabriquer des pizzas napolitaines artisanales traditionnelles par les pizzaïolos napolitains » est inscrit au patrimoine mondial de l'UNESCO depuis 2017.",
              style: TextStyle(fontSize: 18),
              maxLines: isShowmore ? 20 : 3,
              overflow: TextOverflow.ellipsis,
              // overflow: TextOverflow.fade,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isShowmore = !isShowmore;
                });
              },
              child: Text(isShowmore ? "Moins" : "PLus",
                  style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
