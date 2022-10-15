// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, sort_child_properties_last, unrelated_type_equality_checks, empty_catches, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:provider/provider.dart';

class ApprovisionnementTeeShirt extends StatelessWidget {
  ApprovisionnementTeeShirt({super.key});

  TextEditingController _quantite = TextEditingController();
  late int quantite = 0;

  @override
  Widget build(BuildContext context) {
    final _produit = Provider.of<serigraphie>(context);
    return Scaffold(
      drawer: DrawerAdminCentre(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
        title: Text(
          _produit.tee_shirt_nom,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
                    _produit.tee_shirt_nom.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(.7),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Vous disposez de  ".toUpperCase() +
                    _produit.quantite_physique.toString().toUpperCase() +
                    " unités de ce produit en stock".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Renseignez bien les informations rélatives à l'approvisionnement svp !"
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
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 40, bottom: 70),
                child: Container(
                    color: Colors.indigo,
                    child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: (() async {
                            quantite = int.parse(_quantite.text);

                            try {
                              await FirebaseFirestore.instance
                                  .collection("tee_shirts")
                                  .doc(_produit.uid)
                                  .update({
                                "approvisionne": false,
                                "quantite_initial":
                                    _produit.quantite_initial + quantite,
                                "quantite_physique":
                                    _produit.quantite_physique + quantite,
                              });

                              _quantite.clear();

                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Le réchargement de stock de " +
                                          _produit.tee_shirt_nom +
                                          " a été effectué avec succès. Vous disponez maintenant de " +
                                          (_produit.quantite_physique +
                                                  quantite)
                                              .toString() +
                                          " " +
                                          _produit.tee_shirt_nom +
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            } catch (e) {
                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Une erreur inattendue s'est produite pendant le réchargement de stock de " +
                                          _produit.tee_shirt_nom.toString() +
                                          "! Vérifiez votre connection internet et réessayez",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                backgroundColor:
                                    Colors.redAccent.withOpacity(.8),
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            }
                          }),
                          child: Text(
                            "Réchargez le stock".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )))),
          ],
        ),
      ),
    );
  }
}
