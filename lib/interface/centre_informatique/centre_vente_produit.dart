// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, must_be_immutable, unused_field, prefer_final_fields, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_facture_vente.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/modele/budget_centre.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class CentreVenteProduits extends StatelessWidget {
  CentreVenteProduits({super.key});

  TextEditingController _quantite = TextEditingController();
  int quantite = 0;

  @override
  Widget build(BuildContext context) {
    final _produit = Provider.of<products>(context);
    final _budget_centre = Provider.of<budgetCentre>(context);
    final _donnes = Provider.of<donnesUtilisateur>(context);

    if (_produit == null) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Crédit",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.greenAccent,
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
          _produit.nom,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                "Enregistrement de vente de ".toUpperCase() +
                    _produit.nom.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "La quantité restante de " +
                    _produit.nom +
                    " en stock est : " +
                    _produit.quantite_physique.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Renseignez bien les informations rélatives à la vente svp "
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.7),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _quantite,
                  decoration: InputDecoration(
                      hintText: "Saisissez la quantité svp",
                      labelText: "Quantité de vente".toUpperCase()),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo, textStyle: TextStyle()),
                    // ignore: sort_child_properties_last
                    child: Text(
                      "Enregistrez la vente".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: (() async {
                      try {
                        quantite = int.parse(_quantite.text);
                        if (_quantite.text.isEmpty || quantite <= 0) {
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Vous n'avez pas renseigné la quantité que vous voudriez vendre ou la quantité renseignée est incorrecte  ! Veuillez réessayez svp !",
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
                        } else {
                          if (quantite > _produit.quantite_physique) {
                            final snack = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Le stock est insuffisant. Vérifiez diminuer le montant de vente et réessayez !!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              backgroundColor: Colors.redAccent.withOpacity(.8),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(4),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          } else {
                            await FirebaseFirestore.instance
                                .collection("centre_vente_produits")
                                .add({
                              'produit_uid': _produit.uid,
                              'user_uid': _donnes.uid,
                              "nom": _produit.nom,
                              "quantite": quantite,
                              "montant": (quantite * _produit.prix_unitaire),
                              "derniere_vente": DateTime.now()
                            });

                            await FirebaseFirestore.instance
                                .collection("budget")
                                .doc(_budget_centre.uid)
                                .set({
                              "benefice": _budget_centre.benefice +
                                  (quantite *
                                      (_produit.prix_unitaire -
                                          _produit.prix_unitaire_achat)),
                              "solde_total": _budget_centre.solde_total +
                                  (quantite * _produit.prix_unitaire),
                              "depense": _budget_centre.depense,
                            });

                            await FirebaseFirestore.instance
                                .collection("produits_centre")
                                .doc(_produit.uid)
                                .update({
                              'benefice': _produit.benefice +
                                  (quantite * _produit.prix_unitaire -
                                      quantite * _produit.prix_unitaire_achat),
                              "quantite_physique":
                                  _produit.quantite_physique - quantite,
                            });

                            _quantite.clear();

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => CentreFactureVente(
                                        prix_unitaire: _produit.prix_unitaire,
                                        produit_nom: _produit.nom.toString(),
                                        produit_quantite_vendu: quantite,
                                        produit_quantite_physique:
                                            _produit.quantite_physique,
                                        produit_uid: _produit.uid,
                                        montant_vente: quantite *
                                            _produit.prix_unitaire))));
                          }
                        }
                        // ignore: empty_catches
                      } catch (e) {
                        final snack = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Une erreur intatte,ndue s'est produite pendant l'enregistrement de vente. Vérifier votreconnection internet et réessayez !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          backgroundColor: Colors.redAccent.withOpacity(.8),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(4),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      }
                    })),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
