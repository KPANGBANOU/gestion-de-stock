// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, dead_code, unused_local_variable, no_leading_underscores_for_local_identifiers, sort_child_properties_last, deprecated_member_use, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, avoid_init_to_null, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';

import 'package:projet/modele/bierre_grand_model.dart';
import 'package:projet/services/user.dart';

class BarApprovisionnerGrandModele extends StatefulWidget {
  BarApprovisionnerGrandModele({
    Key? key,
    required this.id,
    required this.nom,
    required this.quantite_initial,
    required this.quantite_physique,
  }) : super(key: key);

  final String id;
  final String nom;
  final int quantite_initial;
  final int quantite_physique;

  @override
  State<BarApprovisionnerGrandModele> createState() =>
      _BarApprovisionnerGrandModeleState();
}

class _BarApprovisionnerGrandModeleState
    extends State<BarApprovisionnerGrandModele> {
  TextEditingController quantite = TextEditingController();

  late String message = "";

  //String type_bierre = "Grand modèle";
  @override
  Widget build(BuildContext context) {
    final listBierres = Provider.of<List<donnesBierresGrandModel>>(context);
    final _utilisateur = Provider.of<Utilisateur>(context);
    final _servicedb = Provider.of<serviceBD>(context);
    print(listBierres.length);
    return Scaffold(
      drawer: DrawerAdminBar(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Nouveau stock"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
            ),
            Text(
              "Approvisionnement du stock de pétit modèle de bierre"
                  .toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Renseignez bien les informations rélative au stock de bièrre selectionné"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent.withOpacity(.7),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            /* Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: TextField(
                controller: quantite,
                keyboardType: TextInputType.number,
                inputFormatters: [MyFilter()],
                decoration: InputDecoration(
                  labelText: "Quantité".toUpperCase(),
                  hintText: "Saisissez la quantité",
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(.8),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        textStyle: TextStyle(backgroundColor: Colors.indigo)),
                    child: Text(
                      "Enregistrez".toUpperCase(),
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: (() {
                      quantite_a_ajouter = int.parse(quantite.text);
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("bierres")
                            .doc("Grand modèle$category")
                            .snapshots(),
                        builder: (context, snapshot) {
                          quantite_physique = (snapshot.data
                              as DocumentSnapshot)['prix_unitaire'];
                          quantite_initial = int.parse((snapshot.data
                              as DocumentSnapshot)['quantite_initial']);
                          var result = _servicedb.addnewstock(
                              "Pétit modèle$category",
                              quantite_a_ajouter,
                              quantite_physique,
                              quantite_initial);
                          if (result == "Failed") {
                            quantite.clear();
                            message =
                                "Ce type de bièrre existe déjà pour le type de modèle que vous avez selectionné";
                          } else {
                            message = "Opération effectué avec succès !";
                            quantite.clear();
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
                          return Container();
                          //BarApprovisionnerGrandModele();
                        },
                      );
                    })),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
