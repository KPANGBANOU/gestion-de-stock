// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/interface/Bar_restaurant/stream_list_credit_client_servant_bar.dart';

import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';

import 'package:projet/modele/credits_vente.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class StatistiqueCreditServantBar extends StatelessWidget {
  StatistiqueCreditServantBar({
    Key? key,
  }) : super(key: key);

  late int total_credit = 0;

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    final _user = Provider.of<donnesUtilisateur>(context);
    final _list_credit = Provider.of<List<CreditsVente>>(context);

    _list_credit.forEach((element) {
      total_credit += element.montant;
    });

    if (_list_credit.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: servantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            _user.prenom + " " + _user.nom,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: CentreServantdrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          _user.prenom + " " + _user.nom,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Statistique des ventes à crédit que vous avez effctué"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              color: Colors.indigo,
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Total des crédits",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    total_credit.toString() + " F",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Voudrize-vous consulter la liste des personnes ayant achété à crédit que vous avez enregistré ?"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, textStyle: TextStyle()),
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamListCreditClientServantBar())));
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Liste des crédits".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
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
