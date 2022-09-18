// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/welcome_default.dart';
import 'package:provider/provider.dart';

import 'package:projet/services/user.dart';

class SuccesAccorderDroits extends StatelessWidget {
  SuccesAccorderDroits({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.secteur,
    required this.role,
  }) : super(key: key);

  final String nom;
  final String prenom;
  final String secteur;
  final String role;

  @override
  Widget build(BuildContext context) {
    final _donnes = Provider.of<donnesUtilisateur>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Droits accordés",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
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
                " Mr/Mme " +
                    _donnes.prenom.toString() +
                    "\nVous venez d'accorder avec succès desdroits d'utilisation de l'application à " +
                    prenom +
                    " " +
                    nom,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                prenom +
                    " " +
                    nom +
                    "peut désormais travailler dans le secteur du " +
                    secteur +
                    " de l'entreprise Déo Gracias en tant que " +
                    role,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, "/accorderDroits");
                  }),
                  child: Text(
                    "Accorder droits à autres",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  onPressed: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Welcome())));
                  }),
                  child: Text(
                    "Retour è l'accueil".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
