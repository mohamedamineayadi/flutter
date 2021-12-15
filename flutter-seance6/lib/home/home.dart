import 'package:flutter/material.dart';

import 'product_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<GameData> _games = [];
  final String baseUrl = "10.0.2.2:9090";

  late Future<bool> fetchedGames;

  Future<bool> fetchgames() async {
    http.Response response = await http.get(Uri.http(baseUrl, "/game"));
    List<dynamic> gamesfromServer = json.decode(response.body);
    for (int i = 0; i < gamesfromServer.length; i++) {
      _games.add(GameData(
          title: gamesfromServer[i]["title"],
          image: gamesfromServer[i]["image"],
          description: gamesfromServer[i]["description"],
          price: int.parse(gamesfromServer[i]["price"].toString()),
          quantity: int.parse(gamesfromServer[i]["quantity"].toString()))
      );
    }

    return true;
  }

  @override
  void initState() {
    fetchedGames = fetchgames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedGames,
        builder: (BuildContext builder, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _games.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductInfo(
                    image: _games[index].image,
                    title: _games[index].title,
                    description: _games[index].description,
                    price: _games[index].price,
                    quantity: _games[index].quantity);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class GameData {
  final String title;
  final String image;
  final String description;
  final int price;
  final int quantity;
  GameData({
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
  });

  @override
  String toString() {
    return 'GameData{title: $title, image: $image, description: $description, price: $price, quantity: $quantity}';
  }
}
