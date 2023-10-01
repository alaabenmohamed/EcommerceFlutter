import 'package:flutter/material.dart';
import 'package:flutter_application/provider/cart.dart';
import 'package:flutter_application/shared/appbar.dart';
import 'package:flutter_application/shared/colors.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: reedd,
          title: Text("Page de paiement"),
          actions: [
            ProductsAndPrice(),
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 600,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: classInstancee.selectProduit.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          subtitle: Text(
                              "\$ ${classInstancee.selectProduit[index].prix}-${classInstancee.selectProduit[index].location}"),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                "${classInstancee.selectProduit[index].path}"),
                          ),
                          title: Text(
                              "${classInstancee.selectProduit[index].name}"),
                          trailing: IconButton(
                              onPressed: () {
                              
                                classInstancee.soustraction(
                                    classInstancee.selectProduit[index]);
                              }, icon: Icon(Icons.remove)),
                        ),
                      );
                    }),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(BTNpink),
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
              child: Text(
                "Payer : \$${classInstancee.prixTotale}",
                style: TextStyle(fontSize: 19),
              ),
            ),
          ],
        ));
  }
}
