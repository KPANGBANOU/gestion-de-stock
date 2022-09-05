// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, unused_local_variable, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/interface/Bar_restaurant/my_filter.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class BarEnregistrerDepense extends StatelessWidget {
  BarEnregistrerDepense({Key? key}) : super(key: key);

  TextEditingController montant = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    return Scaffold(
      drawer: DrawerAdminBar(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Dépense",
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
                      color: Colors.redAccent.withOpacity(.6),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                      fontSize: 20),
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
                  controller: description,
                  decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.8),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.white.withOpacity(.8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [MyFilter()],
                  controller: montant,
                  decoration: InputDecoration(
                      hintText: "Montant",
                      labelText: "Montant",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.8),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.white.withOpacity(.8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 70),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        var message = "";

                        var response = add_depense(
                            utilisateur.uid, description.text, montant.text);

                        if (response != "Succes") {
                          message =
                              "Votre depense a été enregistré avec succès !"
                                  .toUpperCase();
                        } else {
                          message =
                              "Une erreure inattendue s'est produite pendant l'enregistrement ! Réeessayez svp !"
                                  .toUpperCase();
                        }

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
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
                        Navigator.of(context)
                            .pushNamed("/barenregistrerdepense");
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
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
            ],
          )),
    );
  }
}

Future<String> add_depense(
    String utilisateurId, String description, String montant) async {
  try {
    await FirebaseFirestore.instance.collection("depenses").add({
      'description': description,
      'montant': montant,
      'user_id': utilisateurId,
      'created_at': FieldValue.serverTimestamp()
    });

    return "Succes";
  } catch (e) {
    return "Echec";
  }
}
