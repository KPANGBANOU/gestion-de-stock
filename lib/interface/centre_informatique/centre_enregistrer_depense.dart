// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, unused_local_variable, unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/modele/budget_centre.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class CentreEnregistrerDepense extends StatelessWidget {
  CentreEnregistrerDepense({Key? key}) : super(key: key);

  TextEditingController _montant = TextEditingController();
  TextEditingController _description = TextEditingController();
  String message = "";
  int montant = 0;
  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUser = Provider.of<donnesUtilisateur>(context);

    final _budget_centre = Provider.of<budgetCentre>(context);
    return Scaffold(
      drawer: CentreServantdrawer(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Enregistrer de dépenses",
          style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(.8)),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 80),
                child: Text(
                  "Enregistrement de dépense".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 50),
                child: Text(
                  "Décrivez brièvement la dépense que vous voudriez enregistrer"
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15, bottom: 20),
                child: TextField(
                    controller: _description,
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _montant,
                  decoration: InputDecoration(
                    hintText: "Montant dépensé",
                    labelText: "Montant",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 70),
                child: Container(
                  color: Colors.indigo,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () async {
                          montant = int.parse(_montant.text);

                          try {
                            if (_description.text.isEmpty ||
                                _montant.text.isEmpty ||
                                montant <= 0) {
                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Tous les champs sont obligatoires svp !",
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
                            } else {
                              await FirebaseFirestore.instance
                                  .collection("depenses_centre")
                                  .add({
                                'user_uid': _utilisateur.uid,
                                'user_nom': _donnesUser.nom,
                                'user_prenom': _donnesUser.prenom,
                                'created_at': DateTime.now(),
                                'description': _description.text,
                                'montant': montant
                              });

                              await FirebaseFirestore.instance
                                  .collection("budget")
                                  .doc(_budget_centre.uid)
                                  .set({
                                'depense': _budget_centre.depense + montant,
                                "solde_total": _budget_centre.solde_total,
                              });

                              _description.clear();
                              _montant.clear();
                              message = _donnesUser.prenom
                                      .toString()
                                      .toUpperCase() +
                                  " ,  Votre depense a été enregistré avec succès !"
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            }
                          } catch (e) {
                            message =
                                "Une erreure inattendue s'est produite pendant l'enregistrement ! Réeessayez svp !"
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
                        },
                        style: ElevatedButton.styleFrom(
                            textStyle:
                                TextStyle(backgroundColor: Colors.indigo)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Enregistrez".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
