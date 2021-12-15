import 'package:flutter/material.dart';
import 'package:seance2flutter/basket/basket.dart';
import 'package:seance2flutter/home/home.dart';
import 'package:seance2flutter/my_games/my_games.dart';

class NavigationTab extends StatelessWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("G-Store ESPRIT"),
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "store",
            ),
            Tab(
              icon: Icon(Icons.article),
              text: "bibliotheque",
            ),
            Tab(
              icon: Icon(Icons.shopping_bag_rounded),
              text: "panier",
            )
          ]),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              AppBar(
                title: const Text("G-Store ESPRIT"),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Modifier profil")
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/home/updateUser");
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.vertical_align_bottom),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Navigation du bas")
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/home");
                },
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [Home(), MyGames(), Basket()]),
      ),
    );
  }
}
