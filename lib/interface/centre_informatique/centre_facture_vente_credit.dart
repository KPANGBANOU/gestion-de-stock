// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_enregistrer_probleme.dart';

import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/interface/centre_informatique/centre_vente_list_credits.dart';
import 'package:projet/interface/centre_informatique/centre_vente_list_produits.dart';
import 'package:projet/interface/centre_informatique/stream_vente_credit.dart';

class CentreFactureVenteCredit extends StatelessWidget {
  CentreFactureVenteCredit({
    Key? key,
    required this.credit_nom,
    required this.credit_montant_vendu,
    required this.credit_montant_restant,
    required this.credit_uid,
  }) : super(key: key);

  final String credit_nom;
  final int credit_montant_vendu;
  final int credit_montant_restant;
  final String credit_uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: CentreServantdrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Facture de vente ",
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
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
                "Facturation de vente de ".toUpperCase() +
                    credit_nom.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Montant total de vente: ".toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    credit_montant_vendu.toString() + " FCFA",
                    style: TextStyle(
                        color: Colors.redAccent.withOpacity(.8),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: TextStyle()),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Vendre encore du ".toUpperCase() +
                            credit_nom.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => StreamVenteCredit(
                                    credit_uid: credit_uid))));
                      },
                    ))),
            SizedBox(
              height: 32,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Vendre autres cr??dits ".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    CentreVenteListCredits())));
                      },
                    ))),
            SizedBox(
              height: 32,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: TextStyle()),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Vendre autres produits".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    CentreVenteListProduits())));
                      },
                    ))),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Avez vous rencontr?? un probl??me pendant l'enregistrement de cette vente ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(.5),
                          textStyle: TextStyle()),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Signalez le probl??me ".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    CentreEnregistrerProbleme())));
                      },
                    ))),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
