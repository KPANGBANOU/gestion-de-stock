// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, prefer_final_fields, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class CentreEnregistrerProbleme extends StatelessWidget {
  CentreEnregistrerProbleme({Key? key}) : super(key: key);

  TextEditingController _description = TextEditingController();
  String message = "";
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<Utilisateur>(context);
    final _service = Provider.of<serviceBD>(context);
    final _donnesUser = Provider.of<donnesUtilisateur>(context);
    return Scaffold(
      drawer: CentreServantdrawer(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "Signaler un problème",
          style: TextStyle(
              color: Colors.white.withOpacity(.8),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  " Si le problème est trés sérieux, contactez svp le PDG ou le Gérant directement"
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150.0, bottom: 50),
                child: Text(
                  "Décrivez brièvement le problème que vous avez rencontré",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 15, bottom: 20),
                child: TextField(
                    controller: _description,
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 40, bottom: 70),
                child: Container(
                  color: Colors.indigo,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () async {
                          try {
                            await FirebaseFirestore.instance
                                .collection("problemes")
                                .add({
                              'user_uid': _donnesUser.uid,
                              'user_nom': _donnesUser.nom,
                              'user_prenom': _donnesUser.prenom,
                              'description': _description.text,
                              'time': DateTime.now()
                            });
                            _description.clear();
                            message = _donnesUser.prenom
                                    .toString()
                                    .toUpperCase() +
                                " , votre problème a té enregistré avec succès"
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
                                "Une erreur intattendue s'est produite pendant l'enregistrement du problème ! Réessayez svp !"
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
                              backgroundColor: Colors.redAccent.withOpacity(.8),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakbar);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                backgroundColor: Colors.indigo,
                                fontWeight: FontWeight.bold)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Enregistrez".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
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
