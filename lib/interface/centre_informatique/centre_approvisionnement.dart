// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, sort_child_properties_last, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:provider/provider.dart';

import '../Bar_restaurant/my_filter.dart';

class CentreApprovisionnement extends StatelessWidget {
  CentreApprovisionnement({super.key});

  TextEditingController _quantite = TextEditingController();
  int quantite = 0;

  @override
  Widget build(BuildContext context) {
    final _bierre = Provider.of<donnesBierresGrandModel>(context);
    final _servicedb = Provider.of<serviceBD>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Nouvel stock"),
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
              "Réchargement de stock de produits ".toUpperCase(),
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
                "Renseignez la quantité d'approvisionnement du" +
                    _bierre.nom.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent.withOpacity(.7),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: TextField(
                controller: _quantite,
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
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      child: Text(
                        "Enregistrez".toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      onPressed: (() {
                        /* quantite = int.parse(_quantite.text);

                        var result = _servicedb.addnewstock(
                            _bierre.uid,
                            quantite,
                            _bierre.quantite_physique,
                            _bierre.quantite_initial);
                        if (result == "Failed") {
                          message =
                              "Ce type de bièrre existe déjà pour le type de modèle que vous avez selectionné";
                        } else {
                          message = "Opération effectué avec succès !";
                          _quantite.clear();
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
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);*/
                      }),
                    ))),
          ],
        ),
      ),
    );
  }
}
