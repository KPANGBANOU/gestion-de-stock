// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/interface/Bar_restaurant/facture_vente_bar.dart';
import 'package:projet/interface/Bar_restaurant/my_filter.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/budgetBar.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import '../../modele/vente.dart';

class VentePetitModele extends StatelessWidget {
  VentePetitModele({super.key});

  TextEditingController _quantite = TextEditingController();
  int quantite = 0;
  int montant = 0;
  String message = "";

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _utilisateur = Provider.of<Utilisateur>(context);
    final _bierre = Provider.of<donneesBieerePetitModele>(context);
    final _user = Provider.of<Utilisateur>(context);
    final _budget_bar = Provider.of<BudgetBar>(context);
    final _vente = Provider.of<vente>(context);
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
                "Renseignement bien svp les informations rélatives à la vente"
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
                inputFormatters: [MyFilter()],
                decoration: InputDecoration(
                  hintText: "Quantité vendue",
                  labelText: "Quantité vendue",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                color: Colors.indigo,
                child: TextButton(
                    onPressed: (() async {
                      quantite = int.parse(_quantite.text);
                      montant = quantite * _bierre.prix_unitaire;

                      try {
                        if (quantite <= _bierre.quantite_physique) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(_user.uid)
                              .collection("ventes")
                              .doc(_bierre.uid)
                              .set({
                            'nom_bierre': _bierre.nom,
                            'category': _bierre.type,
                            'quantite': _vente.quantite + quantite,
                            'montant': _vente.montant +
                                quantite * _bierre.prix_unitaire,
                            'time': DateTime.now(),
                          });

                          await FirebaseFirestore.instance
                              .collection("bierres")
                              .doc(_bierre.uid)
                              .update({
                            'quantite_physique':
                                _bierre.quantite_physique - quantite,
                          });

                          await FirebaseFirestore.instance
                              .collection("budget")
                              .doc(_budget_bar.uid)
                              .update({
                            'solde_total': _budget_bar.solde_total + montant,
                          });

                          _quantite.clear();

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => FactureVenteBar(
                                      montant: montant,
                                      uid: _bierre.uid,
                                      quantite: quantite,
                                      prix_unitaire: _bierre.prix_unitaire,
                                      nom: _bierre.nom,
                                      category: _bierre.type))));
                        } else {
                          // ignore: prefer_interpolation_to_compose_strings
                          message = "Stock de  " +
                              _bierre.nom +
                              " insuffisant pour effectuer cette achat. IL nereste que " +
                              _bierre.quantite_physique.toString() +
                              " en stock !";

                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.redAccent.withOpacity(.7),
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            backgroundColor: Colors.indigo,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);
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
                          backgroundColor: Colors.indigo,
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
