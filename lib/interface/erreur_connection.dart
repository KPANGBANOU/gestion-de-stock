// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ErreurConnection extends StatelessWidget {
  const ErreurConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Erreur de connection",
          style: TextStyle(color: Colors.blueGrey, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.32,
              ),
              Icon(Icons.warning, color: Colors.yellowAccent),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Erreur de connexion ! Vérifiez votre connection internet s'il vous plait.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(.9)),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/wrapper");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Réessayez",
                    style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(.7)),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
