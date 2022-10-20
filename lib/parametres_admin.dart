// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projet/interface/drawer.dart';

import 'modifier_email_rapport.dart';
import 'modifier_numero_watsapp_rapport.dart';

class ParametresAdmin extends StatelessWidget {
  const ParametresAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerHome(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Pramètres",
            style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigoAccent,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Pramètres d'administration du logiciel ".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, textStyle: TextStyle()),
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ModifierEmailRapport())));
                }),
                child: Text(
                  "Modifier l'email de réception de rapports de vente",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, textStyle: TextStyle()),
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ModifierPasswordAdmin())));
                }),
                child: Text(
                  "Ajouter un contact de l'entreprise",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, textStyle: TextStyle()),
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ModifierNumeroWatsappRapport())));
                }),
                child: Text(
                  "Modifier le numero watsapp de reception de rapport",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ));
  }
}
