// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, must_be_immutable, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

class VendrePetitModel extends StatelessWidget {
  VendrePetitModel({Key? key}) : super(key: key);

  TextEditingController _quantite = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _utilisateur = Provider.of<Utilisateur>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Grand modèle".toUpperCase(),
          style: TextStyle(
            color: Colors.white.withOpacity(.7),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.greenAccent,
      drawer: servantdrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Enregistrement de vente des bièrres petit modèle"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Renseignez bien les champs s'il vous plait !",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Informations sur la vente de Coca-cola".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _quantite,
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: (() {}),
                  child: Text(
                    "Enregistrez".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(.8)),
                  )),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
