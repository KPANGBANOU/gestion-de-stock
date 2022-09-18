// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';

class InfoEmploye extends StatelessWidget {
  InfoEmploye({Key? key}) : super(key: key);

  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Informations personnelle",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recueil d'informations personnelles sur un employé de l'entreprise"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Rassurez vous svp que les informations de l'employé sont correctes"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  autofocus: true,
                  controller: _email,
                  decoration: InputDecoration(
                      labelText: "Email de l'employè".toUpperCase(),
                      hintText: "Renseignez l'email de l'employè"),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: (() {}),
                  child: Text(
                    "Recherchez".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
