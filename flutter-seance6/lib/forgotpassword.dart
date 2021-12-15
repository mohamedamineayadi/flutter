import 'package:flutter/material.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);
  static const String id="idForgotpassword";
  @override
  State<Forgotpassword> createState() => _SigninState();
}

class _SigninState extends State<Forgotpassword> {
  late String? username;

  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rénitialiser le mot de ppsse"),
      ),
      body: Form(
        key: keyForm,
        child: ListView(
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Image.asset("assets/images/minecraft.jpg",
                    width: 460, height: 215)),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Username"),
                keyboardType: TextInputType.name,
                onSaved: (String? value) {
                  username = value;
                },
                validator: (value) {
                  if (value!.isEmpty) //unrap ! mara bark
                    return "Username ne doit pas etre vide";
                  if (value.length < 5)
                    return "Username ne doit pas etre inferieur a 5 caracter";
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text("S'authentifier"),
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      keyForm.currentState!.save();
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
