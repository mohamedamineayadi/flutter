import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String? _username;

  final String baseUrl = "10.0.2.2:9090";
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réinitialiser le mot de passe"),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Image.asset("assets/images/minecraft.jpg", width: 460, height: 215)
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Username"),
                onSaved: (String? value) {
                  _username = value;
                },
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return "Le username ne doit pas etre vide";
                  }
                  else if(value.length < 5) {
                    return "Le username doit avoir au moins 5 caractères";
                  }
                  else {
                    return null;
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text("Réinitialiser le mot de passe"),
                  onPressed: () {
                    if(_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();

                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=utf-8"
                      };
                      http.patch(
                          Uri.http(baseUrl, "/user/pwd/"+_username!),
                          headers: headers,
                          body: null
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

                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
