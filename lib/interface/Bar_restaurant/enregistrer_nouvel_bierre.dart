// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, prefer_const_declarations, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/interface/Bar_restaurant/my_filter.dart';

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

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final service = Provider.of<serviceBD>(context);
    String message = "";
    String prix = "";
    String seuil = "";
    String quantite = "";

    late String nomProduit;
    late int quantiteInitial;
    late int prixUnitaire;
    late int seuilAprovisionnement;

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
                child: TextFormField(
                  validator: ((value) {
                    if (value!.length <= 2) {
                      return "La nom est vide ou invalide";
                    }
                    return null;
                  }),
                  onSaved: (value) {
                    nomProduit = value as String;
                  },
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
                        width: 1,
                      ),
                    ),
                    labelText: "Entrez le nom du produit",
                    hintText: "nom du produit".toUpperCase(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
                  validator: ((value) {
                    if (value!.length <= 0) {
                      return "Le prix unitaire est vide ou invalide";
                    }
                    return null;
                  }),
                  keyboardType: TextInputType.number,
                  inputFormatters: [MyFilter()],
                  onSaved: (value) {
                    prixUnitaire = value as int;
                  },
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
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: ((value) {
                    if (value!.length <= 0) {
                      return "La quantité initiale est vide ou invalide";
                    }
                    return null;
                  }),
                  inputFormatters: [MyFilter()],
                  onSaved: ((value) {
                    quantiteInitial = value as int;
                  }),
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
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
                  validator: ((value) {
                    if (value!.length <= 0) {
                      return "Le seuil d'approvisionnement est vide ou invalide";
                    }
                    return null;
                  }),
                  keyboardType: TextInputType.number,
                  inputFormatters: [MyFilter()],
                  onSaved: (value) {
                    seuilAprovisionnement = value as int;
                  },
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
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 15.0, left: 15, bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        var result = service.addNouvelBiar(
                            nomProduit,
                            type_bierre_selectionne,
                            prixUnitaire,
                            quantiteInitial,
                            quantiteInitial,
                            seuilAprovisionnement);
                        if (result == "Failed") {
                          message =
                              "Ce type de bièrre existe déjà pour le type de modèle que vous avez selectionné";
                        } else {
                          message = "Opération effectué avec succès !";
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

                        // ignore: prefer_interpolation_to_compose_strings

                        Navigator.of(context).pushNamed("/barsavanewproduct");
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
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
