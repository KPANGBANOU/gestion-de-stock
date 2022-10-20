// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/drawer.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class SuccesAccorderDroits extends StatelessWidget {
  SuccesAccorderDroits({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _donnes = Provider.of<donnesUtilisateur>(context);
    final _employe = Provider.of<donnesServants>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: DrawerHome(),
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
                    _employe.prenom.toString() +
                    " " +
                    _employe.nom.toString(),
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
                _employe.prenom.toString() +
                    " " +
                    _employe.nom.toString() +
                    "peut désormais travailler sur l'application de gestion de stock  de l'entreprise Déo Gracias en tant que " +
                    _employe.role.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
