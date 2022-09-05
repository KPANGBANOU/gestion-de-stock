// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_string, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _utilisateur = Provider.of<Utilisateur>(context);
    return Scaffold(
        drawer: Drawer(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text("Déo Gracias"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _donnesUtilisateur.nom.toString().toUpperCase() + " ,",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Nous vous souhaitons la bienvenue sur DGracias!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Mr/Mme " +
                      _donnesUtilisateur.nom.toString() +
                      "  vous venez à peine de créer votre compte sur DGracias, le logiciel de gestion de stock. Ainsi , nous vous prions de patienter dans un bref temps, le temps que l'administrateur puisse vous accorder les droits d'usage de l'application. Toute fois, vous pouvez signaler l'entreprise via les contacts enumérés dans le menu de contacts afin d'avoir le plus vite possible de satisfaction! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(.9)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _donnesUtilisateur.nom.toString() +
                      " Exlorez les services de l'entreprise Déo Gracias",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ));
  }
}
