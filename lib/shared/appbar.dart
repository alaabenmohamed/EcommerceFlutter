




// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/checkout.dart';
import '../provider/cart.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return    Row(
              children: [
                Stack(
                  children: [
                    IconButton(
                        onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkout(),
                    ),
                  );

                        }, icon: Icon(Icons.add_shopping_cart)),
                    Positioned(
                      bottom: 18,
                      child: Container(
                          child: Consumer<Cart>(
                              builder: ((context, classInstancee, child) {
                            return Text(
                              ("${classInstancee.itemCount}"),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            );
                          })),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(211, 164, 255, 193),
                              shape: BoxShape.circle)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Consumer<Cart>(
                      builder: ((context, classInstancee, child) {
                    return Text(
                      ("\$${classInstancee.prixTotale}"),
                      // style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    );
                  })),
                )
              ],
            );
          
  }
}