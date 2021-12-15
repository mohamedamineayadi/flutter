import 'package:flutter/material.dart';
import 'package:seance2flutter/product_details.dart';
import 'package:seance2flutter/signup.dart';

class ProductInfo extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int price;
  final int quantity;
  const ProductInfo({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // print("test");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetails(image, title, description, price, quantity);
          }));
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: Image.network("http://10.0.2.2:9090/img/" + image,
                  width: 200, height: 94),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                const SizedBox(
                  height: 10,
                ),
                Text(price.toString() + " TND", textScaleFactor: 2)
              ],
            )
          ],
        ),
      ),
    );
  }
}
