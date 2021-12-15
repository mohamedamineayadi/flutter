import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String? _username;
  late String? _email;
  late String? _pwd;
  late String? _birth;
  late String? _address;

  final String baseUrl = "10.0.2.2:9090";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Image.asset("assets/images/minecraft.jpg",
                    width: 460, height: 215)),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Username"),
                onSaved: (String? value) {
                  _username = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return "Le Username doit avoir au moins 5 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
                onSaved: (String? value) {
                  _email = value;
                },
                validator: (String? value) {
                  RegExp regex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value!.isEmpty || !regex.hasMatch(value)) {
                    return "L'adresse email n'est pas valide !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Mot de passe"),
                onSaved: (String? value) {
                  _pwd = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return "Le mot de passe doit avoir au moins 5 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Année de naissance"),
                onSaved: (String? value) {
                  _birth = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || int.parse(value) > 2021) {
                    return "L'année de naissance est invalide !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Adresse de facturation"),
                onSaved: (String? value) {
                  _address = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 20) {
                    return "L'adresse doit avoir au moins 20 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("S'inscrire"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=utf-8"
                      };
                      Map<String, dynamic> body = {
                        "username": _username!,
                        "email": _email!,
                        "password": _pwd!,
                        "birth": _birth!,
                        "address": _address!
                      };
                      http.post(
                        Uri.http(baseUrl, "/user/signup"),
                        headers: headers,
                        body: json.encode(body)
                      ).then((response) {
                        if (response.statusCode == 200 || response.statusCode == 201){
                          Navigator.pushReplacementNamed(context, "/");
                        }else{
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text("Informations"),
                                  content: Text("Erreur"),
                                );
                              }
                          );
                        }
                      });

                      String message = "Username : " +
                          _username! +
                          "\n" +
                          "Email : " +
                          _email! +
                          "\n" +
                          "Mot de passe : " +
                          _pwd! +
                          "\n" +
                          "Année de naissance : " +
                          _birth! +
                          "\n" +
                          "Adresse de facturation : " +
                          _address!;

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Informations"),
                            content: Text(message),
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  child: const Text("Annuler"),
                  onPressed: () {
                    _formKey.currentState!.reset();
                    Navigator.pushReplacementNamed(context, "/");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
