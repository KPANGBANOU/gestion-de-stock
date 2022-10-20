// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_local_variable, dead_code

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';

import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/donnesservants.dart';

import 'package:projet/modele/vente_petit_modele.dart';

import 'package:provider/provider.dart';

import '../../modele/credit.dart';
import '../../modele/vente_credit.dart';

class StatistiqueJournalierEmployeBarCreditPetitModele extends StatelessWidget {
  StatistiqueJournalierEmployeBarCreditPetitModele({super.key});
  late int produit_lenght = 0;
  late double produit_sizebox = 0;
  late int total_produit = 0;
  late int montant_produit_vendu = 0;
  late int nombre_vente_produit;
  late int quantite = 0;
  late String day = DateFormat('dd').format(DateTime.now());

  late int credit_lenght = 0;
  late double credit_sizebox = 0;
  late int total_credit = 0;
  late int montant_credit_vendu = 0;
  late int nombre_vente_credit;

  late int totaux = 0;

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesServants>(context);
    final _listVente_produits = Provider.of<List<ventePetitModele>>(context);
    final _list_produits = Provider.of<List<donneesBieerePetitModele>>(context);
    final _listVenteCredit = Provider.of<List<venteCredit>>(context);
    final _list_credits = Provider.of<List<credit>>(context);

    credit_lenght = _list_credits.length;

    if (credit_lenght <= 5) {
      credit_sizebox = 180;
    } else if (credit_lenght <= 20) {
      credit_sizebox = 350;
    } else if (credit_lenght <= 30) {
      credit_sizebox = 500;
    } else if (credit_lenght <= 50) {
      credit_sizebox = 600;
    } else {
      credit_sizebox = MediaQuery.of(context).size.height;
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

    if (_listVenteCredit.isEmpty ||
        _list_credits.isEmpty ||
        _listVente_produits.isEmpty ||
        _list_produits.isEmpty) {
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

    if (_listVenteCredit.isEmpty || _listVente_produits.isEmpty) {
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
          child: CircularProgressIndicator(color: Colors.white),
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
                  "statistique journalier de vente de ".toUpperCase() +
                      _donnesUtilisateur.prenom.toString().toUpperCase() +
                      " " +
                      _donnesUtilisateur.nom.toString().toUpperCase() +
                      " au niveau du bar restaurant de l'entreprise Déo Gracias"
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
                  "Vente de bièrres pétit modèle".toUpperCase(),
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
                        "Bièrre",
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
                      donneesBieerePetitModele _credit = _list_produits[index];

                      _listVente_produits.forEach((element) {
                        if (element.date_vente_day == day) {
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
                        "Montant total bièrres",
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
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: 45,
                color: Colors.redAccent.withOpacity(.7),
                child: Text(
                  "Vente de crédits".toUpperCase(),
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

                      _listVenteCredit.forEach((element) {
                        if (element.date_vente_day == day) {
                          nombre_vente_credit++;
                          montant_credit_vendu += element.montant;
                          total_credit += element.montant;
                        }

                        totaux += total_credit;
                      });

                      if (nombre_vente_credit > 0) {
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                montant_credit_vendu.toString() + " F",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }
                      return Container();
                      nombre_vente_credit = 0;
                      montant_credit_vendu = 0;
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
                        "Montant total crédit",
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
            ],
          ),
        ));
  }
}
