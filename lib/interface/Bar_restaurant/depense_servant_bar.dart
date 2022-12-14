// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';

import 'package:projet/modele/depense.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class DepenseServantBar extends StatelessWidget {
  DepenseServantBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    final _user = Provider.of<donnesUtilisateur>(context);
    final _depense = Provider.of<donnesDepense>(context);
    return Scaffold(
      drawer: servantdrawer(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Dépense",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
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
                "Dépense enregistré".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Description de la dépense éffectuée".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.7),
                    letterSpacing: 2,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Il s'agit de ".toUpperCase() +
                    _depense.description.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Montant dépensé",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    _depense.montant.toString() + " F",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Dépense ffectué le",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    _depense.date,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
