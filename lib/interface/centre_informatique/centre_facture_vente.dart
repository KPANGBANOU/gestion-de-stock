// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:projet/interface/centre_informatique/centre_enregistrer_probleme.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/interface/centre_informatique/centre_vente_list_credits.dart';
import 'package:projet/interface/centre_informatique/stream_vente_produit.dart';

class CentreFactureVente extends StatelessWidget {
  CentreFactureVente({
    Key? key,
    required this.produit_nom,
    required this.produit_quantite_vendu,
    required this.produit_quantite_physique,
    required this.produit_uid,
    required this.montant_vente,
    required this.prix_unitaire,
  }) : super(key: key);

  final String produit_nom;
  final int produit_quantite_vendu;
  final int produit_quantite_physique;
  final String produit_uid;
  final int montant_vente;
  final int prix_unitaire;

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
                    produit_nom.toUpperCase(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Prix unitaire de vente: ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  prix_unitaire.toString() + " F",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Quantité vendue: ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  produit_quantite_vendu.toString() + " F",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Montant total de vente: ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  montant_vente.toString() + " F",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Quantité restante en stock: ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  produit_quantite_physique.toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Vendre du ".toUpperCase() + produit_nom.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => StreamVenteProduit(
                                    produit_uid: produit_uid))));
                      },
                    ))),
            SizedBox(
              height: 12,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Vendre autres produits ".toUpperCase(),
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
              height: 12,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Vendre du crédit".toUpperCase(),
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Avez vous rencontré un problème pendant l'enregistrement de cette vente ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.8),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Signalez le problème ".toUpperCase(),
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
            )
          ],
        ),
      ),
    );
  }
}
