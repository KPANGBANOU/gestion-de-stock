// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_const_constructors_in_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls, dead_code

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_tee_shirts.dart';
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
  late int nombre_vente_credit = 0;
  late int nombre_vente_produits = 0;
  late int nombre_vente_tee_shirt = 0;
  late int total_tee_shirt = 0;
  late int tee_shirt_lengh = 0;
  late double tee_shirt_sizebox = 0;
  late int quantite_produit = 0;
  late int montant_produit = 0;
  late int quantite_tee_shirt = 0;
  late int montant_tee_shirt = 0;
  late int montant_credit = 0;

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesServants>(context);
    final _listVente = Provider.of<List<centreVente>>(context);
    final _listVenteCredit = Provider.of<List<venteCredit>>(context);
    final _list_vente_tee_shirt = Provider.of<List<venteteeshirts>>(context);
    final _list_tee_shirt = Provider.of<List<serigraphie>>(context);
    final _list_produits = Provider.of<List<products>>(context);
    final _list_credits = Provider.of<List<credit>>(context);
    credit_lenght = _list_credits.length;
    produit_lenght = _list_produits.length;
    tee_shirt_lengh = _list_tee_shirt.length;

    _listVenteCredit.forEach((element) {
      total_credit = total_credit + element.montant;
    });

    _listVente.forEach((element) {
      total_produit = total_produit + element.montant;
    });

    _list_vente_tee_shirt.forEach((element) {
      total_tee_shirt += element.montant;
    });

    totaux = total_credit + total_produit + total_tee_shirt;

    if (credit_lenght <= 5) {
      credit_sizebox = 280;
    } else if (credit_lenght <= 20) {
      credit_sizebox = 410;
    } else if (credit_lenght <= 30) {
      credit_sizebox = 600;
    } else if (credit_lenght <= 50) {
      credit_sizebox = 700;
    } else {
      credit_sizebox = MediaQuery.of(context).size.height;
    }

    if (tee_shirt_lengh <= 5) {
      tee_shirt_sizebox = 280;
    } else if (tee_shirt_lengh <= 20) {
      tee_shirt_sizebox = 420;
    } else if (tee_shirt_lengh <= 30) {
      tee_shirt_sizebox = 600;
    } else if (tee_shirt_lengh <= 50) {
      tee_shirt_sizebox = 700;
    } else {
      tee_shirt_sizebox = MediaQuery.of(context).size.height;
    }

    if (produit_lenght <= 5) {
      produit_sizebox = 280;
    } else if (produit_lenght <= 20) {
      produit_sizebox = 420;
    } else if (produit_lenght <= 30) {
      produit_sizebox = 600;
    } else if (produit_lenght <= 50) {
      produit_sizebox = 700;
    } else {
      produit_sizebox = MediaQuery.of(context).size.height;
    }

    if (_listVente.isEmpty &&
        _listVenteCredit.isEmpty &&
        _list_credits.isEmpty &&
        _list_produits.isEmpty &&
        _list_tee_shirt.isEmpty &&
        _list_vente_tee_shirt.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          title: Text(
            _donnesUtilisateur.prenom.toString() +
                " " +
                _donnesUtilisateur.nom.toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
        ),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (_listVente.isNotEmpty &&
        _listVenteCredit.isEmpty &&
        _list_vente_tee_shirt.isEmpty) {
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
                  height: 72,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.redAccent.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vente de produits".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                          "Produit",
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
                  height: produit_sizebox,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: ((context, index) {
                        products _vente = _list_produits[index];
                        nombre_vente_tee_shirt = 0;
                        quantite_tee_shirt = 0;
                        montant_tee_shirt = 0;

                        _listVente.forEach((element) {
                          if (element.nom_produit == _vente.nom) {
                            nombre_vente_produits++;
                            quantite_produit += element.quantite;
                            montant_produit += element.montant;
                          }
                        });

                        return nombre_vente_produits > 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      _vente.nom,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      _vente.prix_unitaire.toString() + " F",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      quantite_produit.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      montant_produit.toString() + " F",
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
                      itemCount: _list_produits.length),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Total vente produits",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_produit.toString() + " F",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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

    if (_listVente.isEmpty &&
        _listVenteCredit.isEmpty &&
        _list_vente_tee_shirt.isNotEmpty) {
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
                  height: 72,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.redAccent.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vente de tee shirt".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                          "Tee shirt",
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
                  height: tee_shirt_sizebox,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: ((context, index) {
                        serigraphie _vente = _list_tee_shirt[index];
                        nombre_vente_tee_shirt = 0;
                        quantite_tee_shirt = 0;
                        montant_tee_shirt = 0;

                        _list_vente_tee_shirt.forEach((element) {
                          if (element.nom_tee_shirts == _vente.tee_shirt_nom) {
                            nombre_vente_tee_shirt++;
                            quantite_tee_shirt += element.quantite;
                            montant_tee_shirt += element.montant;
                          }
                        });

                        return nombre_vente_tee_shirt > 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      _vente.tee_shirt_nom,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      _vente.prix_unitaire_vente.toString() +
                                          " F",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      quantite_tee_shirt.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      montant_tee_shirt.toString() + " F",
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
                      itemCount: _list_tee_shirt.length),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Total vente tee shirt",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_tee_shirt.toString() + " F",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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

    if (_listVente.isNotEmpty &&
        _listVenteCredit.isEmpty &&
        _list_vente_tee_shirt.isNotEmpty) {
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
                  height: 72,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.redAccent.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vente de produits".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                          "Produit",
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
                  height: produit_sizebox,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: ((context, index) {
                        products _vente = _list_produits[index];
                        nombre_vente_produits = 0;
                        quantite_produit = 0;
                        montant_produit = 0;

                        _listVente.forEach((element) {
                          if (element.nom_produit == _vente.nom) {
                            nombre_vente_produits++;
                            quantite_produit += element.quantite;
                            montant_produit += element.montant;
                          }
                        });

                        return nombre_vente_produits > 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      _vente.nom,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      _vente.prix_unitaire.toString() + " F",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      quantite_produit.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      montant_produit.toString() + " F",
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
                      itemCount: _list_produits.length),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Total vente produits",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_produit.toString() + " F",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.redAccent.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vente de tee shirt".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                          "Tee shirt",
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
                  height: tee_shirt_sizebox,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: ((context, index) {
                        serigraphie _vente = _list_tee_shirt[index];
                        nombre_vente_tee_shirt = 0;
                        quantite_tee_shirt = 0;
                        montant_tee_shirt = 0;

                        _list_vente_tee_shirt.forEach((element) {
                          if (element.nom_tee_shirts == _vente.tee_shirt_nom) {
                            nombre_vente_tee_shirt++;
                            quantite_tee_shirt += element.quantite;
                            montant_tee_shirt += element.montant;
                          }
                        });

                        return nombre_vente_tee_shirt > 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      _vente.tee_shirt_nom,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      _vente.prix_unitaire_vente.toString() +
                                          " F",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      quantite_tee_shirt.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      montant_tee_shirt.toString() + " F",
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
                      itemCount: _list_tee_shirt.length),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Total vente tee shirt",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_tee_shirt.toString() + " F",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Total vente produits",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_produit.toString() + " F",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Totaux vente",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          totaux.toString() + " F",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ));
    }

    if (_listVente.isEmpty &&
        _listVenteCredit.isNotEmpty &&
        _list_vente_tee_shirt.isEmpty) {
      return Scaffold(
          backgroundColor: Colors.greenAccent,
          drawer: DrawerAdminCentre(),
          appBar: AppBar(
            title: Text(
              _donnesUtilisateur.prenom.toString() +
                  " " +
                  _donnesUtilisateur.nom.toString(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    "Statistique de vente générale de ".toUpperCase() +
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
                  width: double.infinity,
                  height: 40,
                  color: Colors.redAccent.withOpacity(.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Vente de crédits".toUpperCase(),
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
                          "Crédit",
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
                        credit _credit = _list_credits[index];
                        nombre_vente_credit = 0;
                        montant_credit = 0;

                        _listVenteCredit.forEach((element) {
                          if (element.nom == _credit.nom) {
                            nombre_vente_credit++;
                            montant_credit += element.montant;
                          }
                        });

                        return nombre_vente_credit > 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      _credit.nom,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      montant_credit.toString() + " F",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            : Container();
                      }),
                      separatorBuilder: ((context, index) => Divider()),
                      itemCount: _list_credits.length),
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
                          "Total vente crédit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          total_credit.toString() + " F",
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

    if (_list_credits.isNotEmpty &&
        _listVente.isEmpty &&
        _list_vente_tee_shirt.isNotEmpty) {
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
                        "Statistique générale de vente  de ".toUpperCase() +
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
                      width: double.infinity,
                      height: 40,
                      color: Colors.redAccent.withOpacity(.7),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Vente de crédits".toUpperCase(),
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
                              "Crédit",
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
                            credit _credit = _list_credits[index];
                            nombre_vente_credit = 0;
                            montant_credit = 0;

                            _listVenteCredit.forEach((element) {
                              if (element.nom == _credit.nom) {
                                nombre_vente_credit++;
                                montant_credit += element.montant;
                              }
                            });

                            return nombre_vente_credit > 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          _credit.nom,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          montant_credit.toString() + " F",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                : Container();
                          }),
                          separatorBuilder: ((context, index) => Divider()),
                          itemCount: _list_credits.length),
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
                              "Total vente crédit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              total_credit.toString() + " F",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.redAccent.withOpacity(.7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Vente de tee shirts".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
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
                              "Tee shirt",
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
                      height: tee_shirt_sizebox,
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: ((context, index) {
                            serigraphie _vente = _list_tee_shirt[index];
                            nombre_vente_tee_shirt = 0;
                            quantite_tee_shirt = 0;
                            montant_tee_shirt = 0;

                            _list_vente_tee_shirt.forEach((element) {
                              if (element.nom_tee_shirts ==
                                  _vente.tee_shirt_nom) {
                                nombre_vente_tee_shirt++;
                                quantite_tee_shirt += element.quantite;
                                montant_tee_shirt += element.montant;
                              }
                            });

                            return nombre_vente_tee_shirt > 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          _vente.tee_shirt_nom,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          _vente.prix_unitaire_vente
                                                  .toString() +
                                              " F",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          quantite_tee_shirt.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          montant_tee_shirt.toString() + " F",
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
                          itemCount: _list_tee_shirt.length),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Total vente tee shirt",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              total_tee_shirt.toString() + " F",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Totaux vente",
                              style: TextStyle(
                                  color: Colors.white,
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
                      height: 70,
                    )
                  ])));
    }

    if (_list_credits.isNotEmpty &&
        _listVente.isNotEmpty &&
        _list_vente_tee_shirt.isEmpty) {
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
                        "Statistique générale de vente  de ".toUpperCase() +
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
                      width: double.infinity,
                      height: 40,
                      color: Colors.redAccent.withOpacity(.7),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Vente de crédits".toUpperCase(),
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
                              "Crédit",
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
                            credit _credit = _list_credits[index];
                            nombre_vente_credit = 0;
                            montant_credit = 0;

                            _listVenteCredit.forEach((element) {
                              if (element.nom == _credit.nom) {
                                nombre_vente_credit++;
                                montant_credit += element.montant;
                              }
                            });

                            return nombre_vente_credit > 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          _credit.nom,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          montant_credit.toString() + " F",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                : Container();
                          }),
                          separatorBuilder: ((context, index) => Divider()),
                          itemCount: _list_credits.length),
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
                              "Total vente crédit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              total_credit.toString() + " F",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.redAccent.withOpacity(.7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Vente de produits".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
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
                              "Produit",
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
                      height: produit_sizebox,
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: ((context, index) {
                            products _vente = _list_produits[index];
                            nombre_vente_produits = 0;
                            quantite_produit = 0;
                            montant_produit = 0;

                            _listVente.forEach((element) {
                              if (element.nom_produit == _vente.nom) {
                                nombre_vente_produits++;
                                quantite_produit += element.quantite;
                                montant_produit += element.montant;
                              }
                            });

                            return nombre_vente_produits > 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                          _vente.prix_unitaire.toString() +
                                              " F",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          quantite_produit.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          montant_produit.toString() + " F",
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
                          itemCount: _list_produits.length),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Total vente produits",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              total_produit.toString() + " F",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Totaux vente",
                              style: TextStyle(
                                  color: Colors.white,
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
                      height: 70,
                    )
                  ])));
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
                      "Statistique générale de vente  de ".toUpperCase() +
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
                    width: double.infinity,
                    height: 40,
                    color: Colors.redAccent.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vente de crédits".toUpperCase(),
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
                            "Crédit",
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
                          credit _credit = _list_credits[index];
                          nombre_vente_credit = 0;
                          montant_credit = 0;

                          _listVenteCredit.forEach((element) {
                            if (element.nom == _credit.nom) {
                              nombre_vente_credit++;
                              montant_credit += element.montant;
                            }
                          });

                          return nombre_vente_credit > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        _credit.nom,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        montant_credit.toString() + " F",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                        separatorBuilder: ((context, index) => Divider()),
                        itemCount: _list_credits.length),
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
                            "Total vente crédit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total_credit.toString() + " F",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.redAccent.withOpacity(.7),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Vente de produits".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
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
                            "Produit",
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
                    height: produit_sizebox,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: ((context, index) {
                          products _vente = _list_produits[index];
                          nombre_vente_produits = 0;
                          quantite_produit = 0;
                          montant_produit = 0;

                          _listVente.forEach((element) {
                            if (element.nom_produit == _vente.nom) {
                              nombre_vente_produits++;
                              quantite_produit += element.quantite;
                              montant_produit += element.montant;
                            }
                          });

                          return nombre_vente_produits > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                        _vente.prix_unitaire.toString() + " F",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        quantite_produit.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        montant_produit.toString() + " F",
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
                        itemCount: _list_produits.length),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Total vente produits",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total_produit.toString() + " F",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.redAccent.withOpacity(.7),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Vente de tee shirt".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
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
                            "Tee shirt",
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
                    height: tee_shirt_sizebox,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: ((context, index) {
                          serigraphie _vente = _list_tee_shirt[index];
                          nombre_vente_tee_shirt = 0;
                          quantite_tee_shirt = 0;
                          montant_tee_shirt = 0;

                          _list_vente_tee_shirt.forEach((element) {
                            if (element.nom_tee_shirts ==
                                _vente.tee_shirt_nom) {
                              nombre_vente_tee_shirt++;
                              quantite_tee_shirt += element.quantite;
                              montant_tee_shirt += element.montant;
                            }
                          });

                          return nombre_vente_tee_shirt > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        _vente.tee_shirt_nom,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        _vente.prix_unitaire_vente.toString() +
                                            " F",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        quantite_tee_shirt.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        montant_tee_shirt.toString() + " F",
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
                        itemCount: _list_tee_shirt.length),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Total vente tee shirts",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total_tee_shirt.toString() + " F",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Totaux vente",
                            style: TextStyle(
                                color: Colors.white,
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
                    height: 70,
                  )
                ])));
  }
}
