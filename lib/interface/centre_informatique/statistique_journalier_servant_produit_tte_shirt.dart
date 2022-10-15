// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_local_variable, dead_code

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/modele/vente_tee_shirts.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

class StatistiqueJournalierServantCentreProduitTeeShirt
    extends StatelessWidget {
  StatistiqueJournalierServantCentreProduitTeeShirt({super.key});
  late int produit_lenght = 0;
  late double produit_sizebox = 0;
  late int total_produit = 0;
  late int montant_produit_vendu = 0;
  late int nombre_vente_produit;
  late int quantite = 0;
  late String day = DateFormat('dd').format(DateTime.now());

  late int tee_shirt_lenght = 0;
  late double tee_shirt_sizebox = 0;
  late int total_tee_shirt = 0;
  late int montant_tee_shirt_vendu = 0;
  late int nombre_vente_tee_shirt;
  late int quantite_tee_shirt = 0;

  late int totaux = 0;

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _listVente_produits = Provider.of<List<centreVente>>(context);
    final _list_produits = Provider.of<List<products>>(context);
    final _listVente_tee_shirt = Provider.of<List<venteteeshirts>>(context);
    final _list_tee_shirt = Provider.of<List<serigraphie>>(context);

    tee_shirt_lenght = _list_tee_shirt.length;

    if (tee_shirt_lenght <= 5) {
      tee_shirt_sizebox = 180;
    } else if (tee_shirt_lenght <= 20) {
      tee_shirt_sizebox = 350;
    } else if (tee_shirt_lenght <= 30) {
      tee_shirt_sizebox = 500;
    } else if (tee_shirt_lenght <= 50) {
      tee_shirt_sizebox = 600;
    } else {
      tee_shirt_sizebox = MediaQuery.of(context).size.height;
    }

    produit_lenght = _list_produits.length;

    if (produit_lenght <= 5) {
      produit_sizebox = 180;
    } else if (produit_lenght <= 20) {
      produit_sizebox = 350;
    } else if (produit_lenght <= 30) {
      produit_sizebox = 500;
    } else if (produit_lenght <= 50) {
      produit_sizebox = 600;
    } else {
      produit_sizebox = MediaQuery.of(context).size.height;
    }

    return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          title: Text(
            _donnesUtilisateur.prenom + " " + _donnesUtilisateur.nom,
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
                  "Votre statistique journalier de vente au niveau du centre informatique de l'entreprise Déo Gracias"
                      .toUpperCase(),
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
                height: 45,
                color: Colors.redAccent.withOpacity(.7),
                child: Text(
                  "Vente de produits".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Produit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Quantité",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Text(
                        "Montant",
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
                height: produit_sizebox,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: ((context, index) {
                      products _credit = _list_produits[index];

                      _listVente_produits.forEach((element) {
                        if (element.vente_day == day) {
                          nombre_vente_produit++;
                          quantite += element.quantite;
                          montant_produit_vendu += element.montant;
                          total_produit += element.montant;
                        }

                        totaux += total_produit;
                      });

                      if (nombre_vente_produit > 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                _credit.nom,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                quantite.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                montant_produit_vendu.toString() + " F",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }
                      return Container();
                      nombre_vente_produit = 0;
                      montant_produit_vendu = 0;
                      quantite = 0;
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Total vente produit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        total_produit.toString() + " F",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: 45,
                color: Colors.redAccent.withOpacity(.7),
                child: Text(
                  "Vente de tee shirts".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Tee shirt",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Quantité",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Text(
                        "Montant",
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
                height: tee_shirt_sizebox,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: ((context, index) {
                      serigraphie _credit = _list_tee_shirt[index];

                      _listVente_tee_shirt.forEach((element) {
                        if (element.date_vente_day == day) {
                          nombre_vente_tee_shirt++;
                          quantite_tee_shirt += element.quantite;
                          montant_tee_shirt_vendu += element.montant;
                          total_tee_shirt += element.montant;
                        }

                        totaux += total_tee_shirt;
                      });

                      if (nombre_vente_tee_shirt > 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                _credit.tee_shirt_nom,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                quantite_tee_shirt.toString() + " F",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                montant_tee_shirt_vendu.toString() + " F",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }
                      return Container();
                      nombre_vente_tee_shirt = 0;
                      montant_tee_shirt_vendu = 0;
                      quantite_tee_shirt = 0;
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "total vente tee shirt".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        total_tee_shirt.toString() + " F",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 14,
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
                        "Totaux ventes".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
}
