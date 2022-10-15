// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, prefer_const_declarations, prefer_is_empty, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class EnregistrerNouvelBierreFormPage extends StatefulWidget {
  EnregistrerNouvelBierreFormPage({Key? key}) : super(key: key);

  @override
  State<EnregistrerNouvelBierreFormPage> createState() =>
      _EnregistrerNouvelBierreFormPageState();
}

class _EnregistrerNouvelBierreFormPageState
    extends State<EnregistrerNouvelBierreFormPage> {
  String type_bierre_selectionne = 'Pétit modèle';

  TextEditingController nomProduit = TextEditingController();
  TextEditingController quantiteInitial = TextEditingController();
  TextEditingController prixUnitaire = TextEditingController();
  TextEditingController seuilAprovisionnement = TextEditingController();
  TextEditingController prixUnitaire_achat = TextEditingController();
  late int prix = 0;
  late int prix_achat = 0;
  late int seuil = 0;
  late int quantite = 0;
  late String nom = "";
  late bool result = false;
  late String conca = "";
  late String conca_lowercase = "";
  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final service = Provider.of<serviceBD>(context);

    return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Nouvel bièrre",
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
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                "Renseignez bien les champs svp".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                    color: Colors.redAccent.withOpacity(.7)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Informations sur la bièrre".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(.7),
                    fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: DropdownButton<String>(
                      value: type_bierre_selectionne,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      items: <String>['Pétit modèle', 'Grand modèle']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          type_bierre_selectionne = newValue!;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: TextField(
                  controller: nomProduit,
                  autofocus: true,
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
                    labelText: "Entrez le nom du produit svp",
                    hintText: "nom du produit".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: prixUnitaire_achat,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    labelText: "Entrez le prix unitaire d'achat svp",
                    hintText: "Prix unitaire d'achat svp".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: prixUnitaire,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    labelText: "Entrez le prix unitaire de vente svp",
                    hintText: "Prix unitaire de vente svp".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: quantiteInitial,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    labelText: "Entrez la quantité initial svp",
                    hintText: " quantit initiale du produit".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                    labelText: "Entrez le seuil d'approvisionnement svp",
                    hintText: "Seuil d'approvisionnement".toUpperCase(),
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
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        prix = int.parse(prixUnitaire.text);
                        quantite = int.parse(quantiteInitial.text);
                        seuil = int.parse(seuilAprovisionnement.text);
                        nom = nomProduit.text;
                        conca_lowercase =
                            nom.toLowerCase() + " " + type_bierre_selectionne;
                        conca = nom + " " + type_bierre_selectionne;
                        prix_achat = int.parse(prixUnitaire_achat.text);

                        try {
                          await FirebaseFirestore.instance
                              .collection("bierres")
                              .doc(conca_lowercase)
                              .get()
                              .then((value) {
                            value.exists ? result = true : result = false;
                          });

                          if (result == false) {
                            if (prix > prix_achat) {
                              // si ce produit n'existespas encore
                              await FirebaseFirestore.instance
                                  .collection("bierres")
                                  .doc(conca_lowercase)
                                  .set({
                                "approvisionne": false,
                                "montant_vendu": 0,
                                "benefice": 0,
                                "prix_unitaire_achat": prix_achat,
                                "nom": nom,
                                "quantite_initial": quantite,
                                "quantite_physique": quantite,
                                "prix_unitaire": prix,
                                "seuil_approvisionnement": seuil,
                                "created_at": DateTime.now(),
                                "update_at": DateTime.now(),
                                "type": type_bierre_selectionne,
                              });

                              nomProduit.clear();
                              quantiteInitial.clear();
                              prixUnitaire.clear();
                              seuilAprovisionnement.clear();
                              prixUnitaire_achat.clear();

                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Le produit " +
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            } else {
                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Il y a une incohérence dans votre enregistrement. Le produit unitaire de vente doit etre plus grand que le prix unitaire d'achat !",
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
                          } else {
                            // si le produit existe

                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Le produit que vous voudriez ajouter existe dejà dans la base de donnée !",
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
