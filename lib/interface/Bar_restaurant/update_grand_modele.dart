// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, prefer_const_declarations, prefer_is_empty, override_on_non_overriding_member, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, prefer_conditional_assignment

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:provider/provider.dart';

import 'package:projet/services/user.dart';

class UpdateGrandModele extends StatelessWidget {
  UpdateGrandModele({
    Key? key,
  }) : super(key: key);

  @override
  final nomProduit = TextEditingController();
  TextEditingController seuilAprovisionnement = TextEditingController();
  TextEditingController prix_unitaire = TextEditingController();

  late int seuil = 0;
  late String nom = "";
  late bool result = true;
  late int prix = 0;

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _produit = Provider.of<donnesBierresGrandModel>(context);

    return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Mise à jour",
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
                  "Mise des informations rélatives au bièrre grand modèle  "
                          .toUpperCase() +
                      _produit.nom.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Renseignez bien les champs svp !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                      color: Colors.redAccent.withOpacity(.7)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Informations rélatives à la mise à jour".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: TextFormField(
                  controller: nomProduit,
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
                    hintText: "Entrez le nouveau nom du produit",
                    labelText: "nouveau nom".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
                  controller: prix_unitaire,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    hintText: "Nouvel prix unitaire svp",
                    labelText: "Prix unitaire".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
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
                    hintText: "Nouveau seuil d'approvisionnement svp",
                    labelText: "Seuil d'approvisionnement".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 15.0, left: 15, bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          seuil = int.parse(seuilAprovisionnement.text);
                          nom = "Grand modèle" + nomProduit.text;
                          prix = int.parse(prix_unitaire.text);

                          if (seuil == null) {
                            seuil = _produit.seuil_approvisionnement;
                          }

                          if (prix == null) {
                            prix = _produit.prix_unitaire;
                          }

                          if (nom != null) {
                            if (nom == _produit.nom) {
                              if (seuil != null && prix != null) {
                                await FirebaseFirestore.instance
                                    .collection("bierres")
                                    .doc(_produit.uid)
                                    .update({
                                  "seuil_approvisionnement": seuil,
                                  "prix_unitaire": prix,
                                  "update_at": DateTime.now()
                                });

                                nomProduit.clear();
                                prix_unitaire.clear();
                                seuilAprovisionnement.clear();

                                final snakbar = SnackBar(
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "La mise à jour de cette bièrre a été effectuée avec succès",
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakbar);
                              } else {
                                nomProduit.clear();
                                prix_unitaire.clear();
                                seuilAprovisionnement.clear();
                                final snakbar = SnackBar(
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "La mise à jour de cette bièrre a été effectuée avec succès",
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakbar);
                              }
                            } else {
                              await FirebaseFirestore.instance
                                  .collection("bierres")
                                  .doc(nom)
                                  .get()
                                  .then((value) {
                                value.exists ? result = true : result = false;
                              });

                              if (!result) {
                                await FirebaseFirestore.instance
                                    .collection("bierres")
                                    .doc(_produit.uid)
                                    .update({
                                  "prix_unitaire": _produit.prix_unitaire,
                                  "nom": nomProduit.text,
                                  "prix_unitaire_achat":
                                      _produit.prix_unitaire_achat,
                                  "seuil_approvisionnement": seuil,
                                  "update_at": DateTime.now(),
                                });

                                nomProduit.clear();
                                prix_unitaire.clear();
                                seuilAprovisionnement.clear();

                                final snakbar = SnackBar(
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "La mise à jour dece produit a été effectué avec succès",
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakbar);
                              } else {
                                final snakbar = SnackBar(
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Le nouveau nom que vous proposez correspondant à une bièrre  qui existe dans la base de donnée !",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
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
                            }
                          } else {
                            nomProduit.clear();
                            prix_unitaire.clear();
                            seuilAprovisionnement.clear();
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "La mise à jour de cette bièrre  a été effectué avec succès",
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
                          // ignore: empty_catches
                        } catch (e) {
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Une erreur inattendue s'est produite pendant cette opération. Vérifiez votre connection internet et réessayez !",
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
                      style: ElevatedButton.styleFrom(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mettre à jour".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
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
