// ignore_for_file: must_be_immutable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:provider/provider.dart';

import '../../modele/donnesservants.dart';
import '../../modele/vente_grand_modele.dart';
import '../../modele/vente_petit_modele.dart';
import 'drawer_admin_bar.dart';

class StatistiqueGrandPetitModele extends StatelessWidget {
  StatistiqueGrandPetitModele({super.key});

  late int peti_model_lenght = 0;
  late int grand_model_lenght = 0;
  late double petit_model_sizebox = 0;
  late double grand_model_sizebox = 0;
  late int total_petit_model = 0;
  late int total_grand_model = 0;
  late int totaux = 0;
  late int nombre_vente_petit_modele = 0;
  late int nombre_vente_grand_modele;
  late int quantite_grand_modele = 0;
  late int quantite_petit_modele = 0;
  late int montant_petit_modele = 0;
  late int montant_grand_modele = 0;

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesServants>(context);
    final _listVentepetitmodel = Provider.of<List<ventePetitModele>>(context);
    final _listVentegrandmodel = Provider.of<List<venteGrandModele>>(context);
    final _list_petit_modele =
        Provider.of<List<donneesBieerePetitModele>>(context);
    final _list_grand_modele =
        Provider.of<List<donnesBierresGrandModel>>(context);
    peti_model_lenght = _list_petit_modele.length;
    grand_model_lenght = _list_grand_modele.length;

    _listVentegrandmodel.forEach((element) {
      total_grand_model = total_grand_model + element.montant;
    });

    _listVentepetitmodel.forEach((element) {
      total_petit_model = total_petit_model + element.montant;
    });

    totaux = total_petit_model + total_grand_model;

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

    if (peti_model_lenght <= 5) {
      petit_model_sizebox = 180;
    } else if (peti_model_lenght <= 20) {
      petit_model_sizebox = 350;
    } else if (peti_model_lenght <= 30) {
      petit_model_sizebox = 500;
    } else if (peti_model_lenght <= 50) {
      petit_model_sizebox = 600;
    } else {
      petit_model_sizebox = 700;
    }

    if (_list_grand_modele.isEmpty ||
        _list_petit_modele.isEmpty ||
        _listVentegrandmodel.isEmpty ||
        _listVentepetitmodel.isEmpty) {
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
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
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
                      "Statistique générale de vente de ".toUpperCase() +
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
                    height: 12,
                  ),
                  Container(
                    color: Colors.redAccent.withOpacity(.7),
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vente de bièrre pétit modèle".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    color: Colors.indigo,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Bièrre",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Quantité",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Montant",
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
                    height: petit_model_sizebox,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: ((context, index) {
                          donneesBieerePetitModele _vente =
                              _list_petit_modele[index];

                          nombre_vente_petit_modele = 0;
                          quantite_petit_modele = 0;
                          montant_petit_modele = 0;

                          _listVentepetitmodel.forEach((element) {
                            if (element.nom_bierre == _vente.nom) {
                              nombre_vente_petit_modele++;
                              montant_petit_modele += element.montant;
                              quantite_petit_modele += element.quantite;
                            }
                          });

                          return nombre_vente_petit_modele > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        _vente.nom,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        quantite_petit_modele.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        montant_petit_modele.toString() + " F",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                        separatorBuilder: ((context, index) => Divider()),
                        itemCount: _list_petit_modele.length),
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
                            "Total vente pétit modèle ".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total_petit_model.toString() + " F",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 72,
                  ),
                  Container(
                    color: Colors.redAccent.withOpacity(.7),
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vente de bièrres  grand modèle".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    color: Colors.green,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Bièrre",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Quantité",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Montant",
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
                          donnesBierresGrandModel _vente =
                              _list_grand_modele[index];

                          nombre_vente_grand_modele = 0;
                          montant_grand_modele = 0;
                          quantite_grand_modele = 0;

                          _listVentegrandmodel.forEach((element) {
                            if (element.nom_bierre == _vente.nom) {
                              nombre_vente_grand_modele++;
                              quantite_grand_modele += element.quantite;
                              montant_grand_modele += element.montant;
                            }
                          });

                          return nombre_vente_grand_modele > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        _vente.nom,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        quantite_grand_modele.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        montant_grand_modele.toString() + " F",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                        separatorBuilder: ((context, index) => Divider()),
                        itemCount: _list_grand_modele.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.green,
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
                            "Total vente grand modèle ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total_grand_model.toString() + " F",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: 50,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Totaux vente".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            totaux.toString() + " F",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ])));
  }
}
