// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_tee_shirts.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'statistique_journalier_centre_servant_credit_produit.dart';
import 'statistique_journalier_servant_centre_credit.dart';
import 'statistique_journalier_servant_centre_credit_tee_shirt.dart';
import 'statistique_journalier_servant_centre_produit.dart';
import 'statistique_journalier_servant_centre_tee_shirt.dart';
import 'statistique_journalier_servant_produit_tte_shirt.dart';

class StatistiqueJournalierVenteServantCentre extends StatelessWidget {
  StatistiqueJournalierVenteServantCentre({
    Key? key,
  }) : super(key: key);

  late int nbre_vente_credit = 0;
  late int nbre_vente_tee_shirt = 0;
  late int nbre_vente_produit = 0;
  late int lengh_credit = 0;
  late int lengh_tee_shirt = 0;
  late int lengh_product = 0;
  late String day = DateFormat('dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    final _user_data = Provider.of<donnesUtilisateur>(context);
    final _list_vente_credit = Provider.of<List<venteCredit>>(context);
    final _list_vente_tee_shirt = Provider.of<List<venteteeshirts>>(context);
    final _list_vente_produits = Provider.of<List<centreVente>>(context);
    final _list_credit = Provider.of<List<credit>>(context);
    final _list_produits = Provider.of<List<products>>(context);
    final _list_tee_shirt = Provider.of<List<serigraphie>>(context);

    lengh_credit = _list_credit.length;
    lengh_product = _list_produits.length;
    lengh_tee_shirt = _list_tee_shirt.length;

    _list_vente_credit.forEach((element) {
      if (element.date_vente_day == day) {
        nbre_vente_credit++;
      }
    });

    _list_vente_produits.forEach((element) {
      if (element.vente_day == day) {
        nbre_vente_produit++;
      }
    });

    _list_vente_tee_shirt.forEach((element) {
      if (element.date_vente_day == day) {
        nbre_vente_tee_shirt++;
      }
    });

    if (_list_produits.isEmpty &&
        _list_credit.isEmpty &&
        _list_tee_shirt.isEmpty) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 0,
          title: Text(
            _user_data.prenom,
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    if (nbre_vente_credit <= 0 &&
        nbre_vente_produit <= 0 &&
        nbre_vente_tee_shirt <= 0) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 0,
          title: Text(
            _user_data.prenom,
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    if (nbre_vente_credit > 0 &&
        nbre_vente_produit <= 0 &&
        nbre_vente_tee_shirt <= 0) {
      return StatistiqueJournalierServantCentreCredit();
    }

    if (nbre_vente_credit <= 0 &&
        nbre_vente_produit > 0 &&
        nbre_vente_tee_shirt <= 0) {
      return StatistiqueJournalierServantCentreProduit();
    }

    if (nbre_vente_credit <= 0 &&
        nbre_vente_produit <= 0 &&
        nbre_vente_tee_shirt > 0) {
      return StatistiqueJournalierServantCentreTeeShirt();
    }

    if (nbre_vente_credit > 0 &&
        nbre_vente_produit > 0 &&
        nbre_vente_tee_shirt <= 0) {
      return StatistiqueJournalierServantCentreCreditProduit();
    }

    if (nbre_vente_credit > 0 &&
        nbre_vente_produit <= 0 &&
        nbre_vente_tee_shirt > 0) {
      return StatistiqueJournalierServantCentreCreditTeeShirt();
    }

    if (nbre_vente_credit <= 0 &&
        nbre_vente_produit > 0 &&
        nbre_vente_tee_shirt > 0) {
      return StatistiqueJournalierServantCentreProduitTeeShirt();
    }

    return StatistiqueJournalierGeneralServantCentre();
  }
}
