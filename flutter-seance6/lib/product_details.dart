import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetails extends StatefulWidget {
  final String _image;
  final String _title;
  final String _description;
  final int _price;
  final int _quantity;

  const ProductDetails(
      this._image, this._title, this._description, this._price, this._quantity);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late int _currentQuantity;
  final String baseUrl = "10.0.2.2:9090";
  @override
  void initState() {
    _currentQuantity = widget._quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Image.network("http://10.0.2.2:9090/img/" +  widget._image,
                  width: 460, height: 215)),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._description),
          ),
          Text(widget._price.toString() + " TND", textScaleFactor: 3),
          Text("Exemplaires disponibles : " + _currentQuantity.toString()),
          const SizedBox(
            height: 50,
          ),
          // SizedBox(
          //   width: 200,
          //   height: 50,
          //   child: ElevatedButton(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: const [
          //         Icon(Icons.shopping_basket_rounded),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Text("Acheter", textScaleFactor: 2)
          //       ],
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         _currentQuantity--;
          //         print(_currentQuantity);
          //       });
          //     },
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.shopping_basket_rounded),
          label: Text("Acheter", textScaleFactor: 1.5),
          onPressed: () {
            http
                .get(Uri.http(baseUrl,
                    "/library/61b0a76f624d753bfc824107/61b0a76f624d753bfc824105"))
                .then((response) {
              Map<String, dynamic> data = json.decode(response.body);
              if (int.parse(data["count"].toString()) != 0) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Informations"),
                        content: Text("Vous possedez deja ce jeu"),
                      );
                    });
              } else {
                Navigator.pop(context);
              }
            });
          }),
    );
  }
}
