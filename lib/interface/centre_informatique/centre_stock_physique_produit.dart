// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/interface/centre_informatique/stream_approvisionner_produit.dart';
import 'package:projet/interface/centre_informatique/stream_update_centre_produit.dart';
import 'package:projet/modele/produit.dart';
import 'package:provider/provider.dart';

class CentreStockPhysiqueProduit extends StatelessWidget {
  const CentreStockPhysiqueProduit({super.key});

  @override
  Widget build(BuildContext context) {
    final _produit = Provider.of<produits>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: DrawerAdminCentre(),
      appBar: AppBar(
        title: Text(
          _produit.nom,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "La liquidité de ".toUpperCase() +
                    _produit.nom +
                    " disponible en stock de l'entreprise".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Quantité initiale :"),
                Text(_produit.quantite_initial.toString())
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Quantité vendue :"),
                Text((_produit.quantite_initial - _produit.quantite_physique)
                    .toString())
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Quantité restante  :"),
                Text(_produit.quantite_physique.toString())
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Voudriez-vous récharchez le stock de ce produit ?"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
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
                        "Réchargez le stock".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    StreamApprovisionnerProduit(
                                        produit_uid: _produit.uid))));
                      },
                    ))),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Voudriez-vous mèttre à jour les informations de "
                        .toUpperCase() +
                    _produit.nom.toUpperCase() +
                    " ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
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
                        "Mèttre à jour".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    StreamUpdateCentreProduit(
                                        produit_uid: _produit.uid))));
                      },
                    ))),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
