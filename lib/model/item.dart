class Item {
  String path;
  double prix;
  String location;
  String name;

  Item(
      {required this.name,
      required this.path,
      required this.prix,
      this.location = "main shop"});
}

final List allImage = [
  Item(
      name: "Produit1",
      path: "assets/img/1.jpg",
      prix: 10.0,
      location: "Paris Shop"),
  Item(
      name: "Produit2",
      path: "assets/img/2.jpg",
      prix: 20.0,
      location: "Tunis Shop"),
  Item(
      name: "Produit3",
      path: "assets/img/3.jpg",
      prix: 30.0,
      location: "Paris Shop"),
  Item(
      name: "Produit4",
      path: "assets/img/4.jpg",
      prix: 40.0,
      location: "Paris Shop"),
  Item(
      name: "Produit5",
      path: "assets/img/5.jpg",
      prix: 50.0,
      location: "Paris Shop"),
  Item(
    name: "Produit6",
    path: "assets/img/6.jpg",
    prix: 60.0,
  ),

  // {"path": "assets/img/1.jpg", "prix": "10"},
  // {"path": "assets/img/2.jpg", "prix": "20"},
  // {"path": "assets/img/3.jpg", "prix": "30"},
  // {"path": "assets/img/4.jpg", "prix": "40"},
  // {"path": "assets/img/5.jpg", "prix": "50"},
  // {"path": "assets/img/6.jpg", "prix": "60"},
];
