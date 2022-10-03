// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, prefer_const_declarations, prefer_is_empty, override_on_non_overriding_member, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class CentreEnregistrerNouveauReseauCredit extends StatelessWidget {
  CentreEnregistrerNouveauReseauCredit({Key? key}) : super(key: key);

  @override
  TextEditingController nomReseau = TextEditingController();
  TextEditingController montantInitial = TextEditingController();
  TextEditingController seuilAprovisionnement = TextEditingController();

  late int seuil = 0;
  late int montant = 0;
  late String nom = "";
  late bool result = true;

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);

    return Scaffold(
        drawer: DrawerAdminCentre(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Nouveau réseau",
            style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 25),
          ),
          backgroundColor: Colors.indigoAccent,
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
                  "Enregistrement d'un nouveau réseau de communication au srock "
                      .toUpperCase(),
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
                  "Informations rélatives au nouveau réseau de communication"
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
                  controller: nomReseau,
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
                    hintText: "Entrez le nom du réseau",
                    labelText: "nom du réseau".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: montantInitial,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    hintText: "Entrez le montant initial",
                    labelText: "montant initial".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: seuilAprovisionnement,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    hintText: "Entrez le seuil d'approvisionnement",
                    labelText: "Seuil d'approvisionnement".toUpperCase(),
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
                          montant = int.parse(montantInitial.text);
                          seuil = int.parse(seuilAprovisionnement.text);
                          nom = nomReseau.text;
                          await FirebaseFirestore.instance
                              .collection("reseaux_communication")
                              .doc(nom)
                              .get()
                              .then((onexist) {
                            onexist.exists ? result = true : result = false;
                          });

                          if (!result) {
                            // si ce produit n'existespas encore
                            await FirebaseFirestore.instance
                                .collection("reseaux_communication")
                                .doc(nom)
                                .set({
                              "benefice": 0,
                              "nom": nom,
                              "montant_initial": montant,
                              "montant_disponible": montant,
                              "seuil_approvisionnement": seuil,
                              "created_at": DateTime.now(),
                              "update_at": DateTime.now()
                            });

                            nomReseau.clear();
                            montantInitial.clear();
                            seuilAprovisionnement.clear();

                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Le réseau " +
                                      nom +
                                      " a été ajouté au stock avec succès",
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
                          } else {
                            // si le produit existe

                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Le réseau  que vous voudriez ajouter existe dejà dans la base de donnée !",
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

                          // ignore: empty_catches
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
                          "Enregistrer".toUpperCase(),
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
