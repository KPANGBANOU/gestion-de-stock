// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, unused_local_variable, unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/Bar_restaurant/my_filter.dart';
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
    final _service = Provider.of<serviceBD>(context);
    final _budget_centre = Provider.of<budgetCentre>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Enregistrer dedépenses",
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
                  "Décrivez brièvement la dépense que vous voudriez enregistrer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(.9), fontSize: 24),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15, bottom: 20),
                child: TextField(
                    autofocus: true,
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
                  inputFormatters: [MyFilter()],
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
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(_utilisateur.uid)
                                .collection("depenses")
                                .add({
                              'created_at': DateTime.now(),
                              'description': _description.text,
                              'montant': montant
                            });

                            await FirebaseFirestore.instance
                                .collection("budget")
                                .doc(_budget_centre.uid)
                                .update({
                              'depense': _budget_centre.depense + montant,
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
                            ScaffoldMessenger.of(context).showSnackBar(snakbar);
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
