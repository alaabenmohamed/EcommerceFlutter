import 'package:flutter/material.dart';

import '../model/item.dart';

class Cart with ChangeNotifier {
  List selectProduit = [];
  int prixTotale = 0;
  add(Item product) {
    selectProduit.add(product);
    notifyListeners();
  }

  prixcalcule(Item product) {
    prixTotale += product.prix.round();
    notifyListeners();
  }
  soustraction(Item product) {
    prixTotale -= product.prix.round();
     selectProduit.remove(product);
    notifyListeners();
  }
  get itemCount {
    return   selectProduit.length;
  }
}
