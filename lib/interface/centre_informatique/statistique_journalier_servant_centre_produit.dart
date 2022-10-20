// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_local_variable, dead_code

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

class StatistiqueJournalierServantCentreProduit extends StatelessWidget {
  StatistiqueJournalierServantCentreProduit({super.key});
  late int credit_lenght = 0;
  late double credit_sizebox = 0;
  late int total_credit = 0;
  late int montant_credit_vendu = 0;
  late int nombre_vente_credit;
  late int quantite = 0;
  late String day = DateFormat('dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _listVente_produits = Provider.of<List<centreVente>>(context);
    final _list_produits = Provider.of<List<products>>(context);

    credit_lenght = _list_produits.length;

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

    if (_listVente_produits.isEmpty || _list_produits.isEmpty) {
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
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
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
                height: credit_sizebox,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: ((context, index) {
                      products _credit = _list_produits[index];

                      _listVente_produits.forEach((element) {
                        if (element.vente_day == day) {
                          nombre_vente_credit++;
                          quantite += element.quantite;
                          montant_credit_vendu += element.montant;
                          total_credit += element.montant;
                        }
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
                        "Montant total vendu",
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
}
