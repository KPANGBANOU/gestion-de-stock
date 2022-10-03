// ignore_for_file: must_be_immutable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modele/donnesservants.dart';
import '../../modele/vente_grand_modele.dart';
import 'drawer_admin_bar.dart';

class StatistiqueServantGrandModel extends StatelessWidget {
  StatistiqueServantGrandModel({super.key});

  late int grand_model_lenght = 0;

  late double grand_model_sizebox = 0;

  late int total_grand_model = 0;

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesServants>(context);
    final _listVentegrandmodel = Provider.of<List<venteGrandModele>>(context);
    _listVentegrandmodel.forEach((element) {
      total_grand_model = total_grand_model + element.montant;
    });
    if (grand_model_lenght <= 5) {
      grand_model_sizebox = 180;
    } else if (grand_model_lenght <= 20) {
      grand_model_sizebox = 350;
    } else if (grand_model_lenght <= 30) {
      grand_model_sizebox = 500;
    } else if (grand_model_lenght <= 50) {
      grand_model_sizebox = 600;
    } else {
      grand_model_sizebox = 700;
    }
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          title: Text(
            _donnesUtilisateur.prenom.toString() +
                " " +
                _donnesUtilisateur.nom.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Statistique de vente de ".toUpperCase() +
                      _donnesUtilisateur.prenom.toString().toUpperCase() +
                      "  " +
                      _donnesUtilisateur.nom.toString().toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 72,
              ),
              Text(
                "Vente de bièrre de catégorie grand modèle".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.indigo,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Nom de bièrre".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Quantité".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "montant".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: grand_model_sizebox,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: ((context, index) {
                      venteGrandModele _vente = _listVentegrandmodel[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              _vente.nom_bierre,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              _vente.quantite.toString(),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              _vente.montant.toString() + " F",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    separatorBuilder: ((context, index) => Divider()),
                    itemCount: _listVentegrandmodel.length),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.indigo,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Total vente ".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        total_grand_model.toString() + " FCFA",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
            ],
          ),
        ));
  }
}
