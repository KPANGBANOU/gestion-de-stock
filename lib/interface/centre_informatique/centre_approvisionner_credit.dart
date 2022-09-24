// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, sort_child_properties_last, unrelated_type_equality_checks, use_build_context_synchronously, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/credit.dart';
import 'package:provider/provider.dart';

class CentreApprovisionnementCredit extends StatelessWidget {
  CentreApprovisionnementCredit({super.key});

  TextEditingController _quantite = TextEditingController();
  int quantite = 0;

  @override
  Widget build(BuildContext context) {
    final _credit = Provider.of<credit>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: DrawerAdminCentre(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Réchargement de " + _credit.nom,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Réchargement de stock de ".toUpperCase() +
                    _credit.nom.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(.7),
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
                "Vous disposez d'un montant de ".toUpperCase() +
                    _credit.montant_disponible.toString().toUpperCase() +
                    " FCFA de ce réseau en stock ".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Renseignez bien le montant d'approvisionnement svp"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent.withOpacity(.7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: TextField(
                controller: _quantite,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Quantité".toUpperCase(),
                  hintText: "Saisissez la quantité",
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(.8),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        textStyle: TextStyle(backgroundColor: Colors.indigo)),
                    child: Text(
                      "Réchargez le stock".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (() async {
                      quantite = int.parse(_quantite.text);

                      try {
                        await FirebaseFirestore.instance
                            .collection("reseaux_communication")
                            .doc(_credit.uid)
                            .update({
                          "montant_disponible":
                              _credit.montant_disponible + quantite,
                          "montant_initial": _credit.montant_initial + quantite,
                        });

                        _quantite.clear();

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Le réchargement de stock de " +
                                    _credit.nom.toString() +
                                    " a été effectué avec succès. Vous disponez maintenant de " +
                                    _credit.montant_disponible.toString() +
                                    " F de " +
                                    _credit.nom.toString() +
                                    "  en stock",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.indigo,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      } catch (e) {
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Une erreur inattendue s'est produite pendant le réchargement de stock de " +
                                    _credit.nom.toString() +
                                    "! Vérifiez votre connection internet et réessayez",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.redAccent.withOpacity(.8),
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      }
                    }),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
