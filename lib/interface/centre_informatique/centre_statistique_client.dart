// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_const_constructors_in_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:provider/provider.dart';

class CentreStatistiqueEmploye extends StatelessWidget {
  CentreStatistiqueEmploye({super.key});

  late int credit_lenght = 0;
  late int produit_lenght = 0;
  late double credit_sizebox = 0;
  late double produit_sizebox = 0;
  late int total_credit = 0;
  late int total_produit = 0;
  late int totaux = 0;

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesServants>(context);
    final _listVente = Provider.of<List<centreVente>>(context);
    final _listVenteCredit = Provider.of<List<venteCredit>>(context);
    credit_lenght = _listVenteCredit.length;
    produit_lenght = _listVente.length;

    _listVenteCredit.forEach((element) {
      total_credit = total_credit + element.montant;
    });

    _listVente.forEach((element) {
      total_produit = total_produit + element.montant;
    });

    totaux = total_credit + total_produit;

    if (credit_lenght <= 5) {
      credit_sizebox = 180;
    } else if (credit_lenght <= 20) {
      credit_sizebox = 350;
    } else if (credit_lenght <= 30) {
      credit_sizebox = 500;
    } else if (credit_lenght <= 50) {
      credit_sizebox = 600;
    } else {
      credit_sizebox = 700;
    }

    if (produit_lenght <= 5) {
      produit_sizebox = 180;
    } else if (produit_lenght <= 20) {
      produit_sizebox = 350;
    } else if (produit_lenght <= 30) {
      produit_sizebox = 500;
    } else if (produit_lenght <= 50) {
      produit_sizebox = 600;
    } else {
      produit_sizebox = 700;
    }

    if (_listVente.isEmpty && _listVenteCredit.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminCentre(),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _donnesUtilisateur.prenom.toString() +
                  " " +
                  _donnesUtilisateur.nom.toString() +
                  " n'a éffectué aucune vente au niveau du centre informatique",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    if (_listVente.isNotEmpty && _listVenteCredit.isEmpty) {
      return Scaffold(
          backgroundColor: Colors.greenAccent,
          drawer: DrawerAdminCentre(),
          appBar: AppBar(
            title: Text(
              _donnesUtilisateur.prenom.toString() +
                  " " +
                  _donnesUtilisateur.nom.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
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
                  "Vente de produits".toUpperCase(),
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
                          "Nom",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Prix unitaire",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Quantité",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "total",
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
                  height: produit_sizebox,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: ((context, index) {
                        centreVente _vente = _listVente[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                _vente.nom_produit,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                _vente.montant.toString() + " F",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
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
                      itemCount: _listVente.length),
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
                          "Total vente ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_produit.toString() + " FCFA",
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

    if (_listVente.isEmpty && _listVenteCredit.isNotEmpty) {
      return Scaffold(
          backgroundColor: Colors.greenAccent,
          drawer: DrawerAdminCentre(),
          appBar: AppBar(
            title: Text(
              _donnesUtilisateur.prenom.toString() +
                  " " +
                  _donnesUtilisateur.nom.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
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
                  height: 12,
                ),
                Text(
                  "Vente de crédits".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent.withOpacity(.7),
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
                          "Nom",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Montant vendu",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: credit_sizebox,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: ((context, index) {
                        venteCredit _credit = _listVenteCredit[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                _credit.nom.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                _credit.montant.toString() + " FCFA",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }),
                      separatorBuilder: ((context, index) => Divider()),
                      itemCount: _listVenteCredit.length),
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
                          "Montant total",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_credit.toString() + " FCFA",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 72,
                ),
              ],
            ),
          ));
    }

    return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminCentre(),
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
                    height: 12,
                  ),
                  Text(
                    "Vente de crédits".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.redAccent.withOpacity(.7),
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
                            "Nom",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Montant vendu",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: credit_sizebox,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: ((context, index) {
                          venteCredit _credit = _listVenteCredit[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(
                                  _credit.nom.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  _credit.montant.toString() + " FCFA",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) => Divider()),
                        itemCount: _listVenteCredit.length),
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
                            "Montant total",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total_credit.toString() + " FCFA",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 72,
                  ),
                  Text(
                    "Vente de produits".toUpperCase(),
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
                            "Nom",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Prix unitaire",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Quantité",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "total",
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
                    height: produit_sizebox,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: ((context, index) {
                          centreVente _vente = _listVente[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(
                                  _vente.nom_produit,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  _vente.montant.toString() + " F",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
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
                        itemCount: _listVente.length),
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
                            "Total vente ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total_produit.toString() + " FCFA",
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Statistique général de vente de ".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    color: Colors.redAccent.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Totaux".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            totaux.toString() + " FCFA",
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
