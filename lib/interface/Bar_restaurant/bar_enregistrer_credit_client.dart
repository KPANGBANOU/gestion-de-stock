// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, prefer_const_declarations, prefer_is_empty, override_on_non_overriding_member, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class BarEnregistrerCreditClient extends StatelessWidget {
  BarEnregistrerCreditClient({Key? key}) : super(key: key);

  @override
  TextEditingController nomClient = TextEditingController();
  TextEditingController prenomClient = TextEditingController();
  TextEditingController montant = TextEditingController();
  TextEditingController descriptionCredit = TextEditingController();

  late int montantCredit = 0;

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);

    return Scaffold(
        drawer: servantdrawer(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Crédit client",
            style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 25),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Enregistrement d'achat par crédit du client ".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Informations rélatives à la vente crédit du client"
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Renseignez bien les champs svp !".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.redAccent.withOpacity(.7)),
                ),
              ),
              SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: TextField(
                  controller: nomClient,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.white.withOpacity(.7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    hintText: "Saisissez  le nom du client svp !",
                    labelText: "Nom du client".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: prenomClient,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    labelText: "Saisissez le prénom du client svp !",
                    hintText: "Prénom du client svp".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: montant,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    labelText: "Saisissez le montant de crédit du client svp !",
                    hintText: "Montant de crédit du client svp".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: descriptionCredit,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    labelText: "Décrivez l'achat effectué par le client svp!",
                    hintText:
                        "Description de l'achat du client svp".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 5, bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          montantCredit = int.parse(montant.text);

                          if (nomClient.text.isEmpty ||
                              prenomClient.text.isEmpty ||
                              montant.text.isEmpty ||
                              descriptionCredit.text.isEmpty ||
                              montantCredit <= 0) {
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "L'une des informations démandées n'a pas été renseignée. Renseignez tous les champs de saisie svp !",
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
                            await FirebaseFirestore.instance
                                .collection("credits")
                                .add({
                              "statut": false,
                              "nom_client": nomClient.text,
                              "prenom_client": prenomClient.text,
                              "montant": montantCredit,
                              "description": descriptionCredit.text,
                              "nom_servant": _donnesUtilisateur.nom,
                              "prenom_servant": _donnesUtilisateur.prenom,
                              "servant_uid": _donnesUtilisateur.uid,
                              "date_vente": DateTime.now()
                            });

                            nomClient.clear();
                            prenomClient.clear();
                            montant.clear();
                            descriptionCredit.clear();

                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Le crédit d'achat du client " +
                                      nomClient.text +
                                      " " +
                                      prenomClient.text +
                                      " a été enregistré avec succès dans la base de données de l'entreprise",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
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
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Une erreur inattendue s'esto produite pendant cette opération. Vérifiez votre connection internet et réessayez !",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
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
                          backgroundColor: Colors.indigo),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Enregistrez".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
