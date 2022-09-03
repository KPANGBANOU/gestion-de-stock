// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';

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
  CollectionReference _user = FirebaseFirestore.instance.collection("users");
  CollectionReference _reference =
      FirebaseFirestore.instance.collection("bierres");

  String type_bierre_selectionne = 'Pétit modèle';

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final service = Provider.of<serviceBD>(context);

    TextEditingController nomProduit = TextEditingController();
    TextEditingController quantiteInitial = TextEditingController();
    TextEditingController prixUnitaire = TextEditingController();
    TextEditingController seuilAprovisionnement = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.greenAccent,
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
                      labelText: "Entrez le nom du produit",
                      hintText: "nom du produit".toUpperCase(),
                      labelStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: quantiteInitial,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                      labelText: "Entrez la quantité initial",
                      hintText: " quantit initiale".toUpperCase(),
                      labelStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: prixUnitaire,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                      labelText: "Entrez le prix unitaire",
                      hintText: "Prix unitaire".toUpperCase(),
                      labelStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextField(
                  controller: seuilAprovisionnement,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                      labelText: "Entrez le seuil d'approvisionnement",
                      hintText: "Seuil d'approvisionnement".toUpperCase(),
                      labelStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.7),
                      )),
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
                        service.addNouvelBiar(
                            nomProduit.text,
                            type_bierre_selectionne,
                            int.parse(prixUnitaire.text),
                            int.parse(quantiteInitial.text),
                            int.parse(quantiteInitial.text),
                            int.parse(seuilAprovisionnement.text));

                        // ignore: prefer_interpolation_to_compose_strings

                        Navigator.of(context).pushNamed("/barsavanewproduct");
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo.withOpacity(.7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Enregistrer".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
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
