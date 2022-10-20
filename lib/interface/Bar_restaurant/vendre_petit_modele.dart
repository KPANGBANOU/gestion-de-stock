// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/interface/Bar_restaurant/facrure_vente_petit_model.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/budgetBar.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class VentePetitModele extends StatelessWidget {
  VentePetitModele({super.key});

  TextEditingController _quantite = TextEditingController();
  int quantite = 0;
  int montant = 0;
  String message = "";

  @override
  Widget build(BuildContext context) {
    final _bierre = Provider.of<donneesBieerePetitModele>(context);
    final _user = Provider.of<donnesUtilisateur>(context);
    final _budget_bar = Provider.of<BudgetBar>(context);

    return Scaffold(
      drawer: servantdrawer(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          _bierre.nom.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 85,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Enregistrement de vente de ".toUpperCase() +
                    _bierre.nom.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
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
                "Renseignement bien svp les informations rélatives à la vente svp"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.75),
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _quantite,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Saisissez la quantité vendue svp ",
                  hintText: "Quantité vendue",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo, textStyle: TextStyle()),
                    onPressed: (() async {
                      quantite = int.parse(_quantite.text);
                      montant = quantite * _bierre.prix_unitaire;

                      try {
                        if (_quantite.text.isEmpty || quantite <= 0) {
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Vous n'avez pas renseigné la quantité que vous voudriez vendre ! Ce champ est obligatoire",
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
                          if (quantite <= _bierre.quantite_physique) {
                            await FirebaseFirestore.instance
                                .collection("ventes_petit_modele")
                                .add({
                              'produit_uid': _bierre.uid,
                              'user_uid': _user.uid,
                              'user_nom': _user.nom,
                              'user_prenom': _user.prenom,
                              'nom_bierre': _bierre.nom,
                              'type': "Grand modèle",
                              'quantite': quantite,
                              'montant': quantite * _bierre.prix_unitaire,
                              'time': DateTime.now(),
                            });

                            await FirebaseFirestore.instance
                                .collection("bierres")
                                .doc(_bierre.uid)
                                .update({
                              'benefice': _bierre.benefice +
                                  (quantite * _bierre.prix_unitaire -
                                      quantite * _bierre.prix_unitaire_achat),
                              'quantite_physique':
                                  _bierre.quantite_physique - quantite,
                            });

                            await FirebaseFirestore.instance
                                .collection("budget")
                                .doc(_budget_bar.uid)
                                .update({
                              'benefice': _budget_bar.benefice +
                                  (quantite * _bierre.prix_unitaire -
                                      quantite * _bierre.prix_unitaire_achat),
                              'solde_total': _budget_bar.solde_total + montant,
                            });

                            _quantite.clear();

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        FactureVenteBarPetitModele(
                                            produit_nom: _bierre.nom,
                                            produit_quantite_vendu: quantite,
                                            produit_quantite_physique:
                                                _bierre.quantite_physique -
                                                    quantite,
                                            produit_uid: _bierre.uid,
                                            montant_vente: quantite *
                                                _bierre.quantite_physique,
                                            prix_unitaire:
                                                _bierre.prix_unitaire))));
                          } else {
                            // ignore: prefer_interpolation_to_compose_strings
                            message = "Erreur ! \n Le stock de  " +
                                _bierre.nom +
                                " insuffisant pour effectuer cet achat. IL nereste que " +
                                _bierre.quantite_physique.toString() +
                                " en stock !";

                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              backgroundColor: Colors.redAccent.withOpacity(.7),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakbar);
                          }
                        }
                      } catch (e) {
                        message =
                            "Une erreur intattendue s'est produite epndant l'enregistrement de votre vente ! Réessayez svp !"
                                .toUpperCase();
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          backgroundColor: Colors.redAccent.withOpacity(.7),
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      }
                    }),
                    child: Text(
                      "Enregistrez".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
