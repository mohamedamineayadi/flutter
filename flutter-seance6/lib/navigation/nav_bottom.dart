import 'package:flutter/material.dart';
import 'package:seance2flutter/basket/basket.dart';
import 'package:seance2flutter/home/home.dart';
import 'package:seance2flutter/my_games/my_games.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  late int current_index = 0;
  final List<Widget> interfaces = const [Home(), MyGames(), Basket()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("G-Store ESPRIT"),
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
                  Icon(Icons.tab),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Navigation par onglet")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/navTab");
              },
            ),
          ],
        ),
      ),
      body: interfaces[current_index],
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "store"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article), label: "bibliotheque"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_rounded), label: "panier")
          ],
          currentIndex: current_index,
          onTap: (value) {
            setState(() {
              current_index = value;
            });
            // print(current_index);
          }),
    );
  }
}
