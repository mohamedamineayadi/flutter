import 'package:flutter/material.dart';
import 'package:seance2flutter/home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'my_game_info.dart';

class MyGames extends StatefulWidget {
  const MyGames({Key? key}) : super(key: key);

  @override
  State<MyGames> createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  final List<GameData> _games = [];
  final String baseUrl = "10.0.2.2:9090";

  late Future<bool> fetchedGamesUser;

  Future<bool> fetchLibraryGames() async {
    http.Response response = await http.get(Uri.http(baseUrl, "/library/61b8ef7db000c058bab63cb7"));
    List<dynamic> userGamesFromServer = json.decode(response.body);
    for(int i = 0; i < userGamesFromServer.length; i++) {
      _games.add(GameData(
          title: userGamesFromServer[i]["title"],
          image: userGamesFromServer[i]["image"],
          description: userGamesFromServer[i]["description"],
          price: userGamesFromServer[i]["price"],
          quantity: userGamesFromServer[i]["quantity"])
      );
    }
    return true;
  }

  @override
  void initState() {
    fetchedGamesUser = fetchLibraryGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedGamesUser,
        builder: (context, snapshot) {
          return GridView.builder(
            itemCount: _games.length,
            itemBuilder: (BuildContext context, int index) {
              return MyGameInfo(_games[index].image, _games[index].title);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 120,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
          );
        },
    );
  }
}
