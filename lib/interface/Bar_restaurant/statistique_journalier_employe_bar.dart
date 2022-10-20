// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';

import 'package:projet/modele/donnesservants.dart';

import 'package:projet/modele/vente_grand_modele.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import '../../modele/bieere_petit_model.dart';
import '../../modele/bierre_grand_model.dart';
import '../../modele/credit.dart';
import '../../modele/vente_credit.dart';
import '../../modele/vente_petit_modele.dart';
import 'statistique_journalier_employe_bar_credit.dart';
import 'statistique_journalier_employe_bar_credit_grand_modele.dart';
import 'statistique_journalier_employe_bar_credit_petit_modele.dart';
import 'statistique_journalier_employe_bar_petit_grand_modele.dart';
import 'statistique_journalier_employe_bar_petit_modele.dart';
import 'statistique_journalier_employe_grand_modele.dart';
import 'statistique_journalier_general_employe_bar.dart';

class StatistiqueJournalierEmployeBar extends StatelessWidget {
  StatistiqueJournalierEmployeBar({
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
    final _user_data = Provider.of<donnesServants>(context);
    final _list_vente_credit = Provider.of<List<venteCredit>>(context);
    final _list_vente_grand_modele =
        Provider.of<List<venteGrandModele>>(context);
    final _list_vente_petit_modele =
        Provider.of<List<ventePetitModele>>(context);
    final _list_credit = Provider.of<List<credit>>(context);
    final _list_petit_modele =
        Provider.of<List<donneesBieerePetitModele>>(context);
    final _list_grand_modele =
        Provider.of<List<donnesBierresGrandModel>>(context);

    lengh_credit = _list_credit.length;
    lengh_product = _list_petit_modele.length;
    lengh_tee_shirt = _list_grand_modele.length;

    _list_vente_credit.forEach((element) {
      if (element.date_vente_day == day) {
        nbre_vente_credit++;
      }
    });

    _list_vente_petit_modele.forEach((element) {
      if (element.date_vente_day == day) {
        nbre_vente_produit++;
      }
    });

    _list_vente_grand_modele.forEach((element) {
      if (element.date_vente_day == day) {
        nbre_vente_tee_shirt;
      }
    });

    if (_list_grand_modele.isEmpty &&
        _list_credit.isEmpty &&
        _list_petit_modele.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminBar(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 0,
          title: Text(
            _user_data.prenom.toString(),
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
        drawer: DrawerAdminBar(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 0,
          title: Text(
            _user_data.prenom.toString(),
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
      return StatistiqueJournalierEmployeBarCredit();
    }

    if (nbre_vente_credit <= 0 &&
        nbre_vente_produit > 0 &&
        nbre_vente_tee_shirt <= 0) {
      return StatistiqueJournalierEmployeBarPetitModele();
    }

    if (nbre_vente_credit <= 0 &&
        nbre_vente_produit <= 0 &&
        nbre_vente_tee_shirt > 0) {
      return StatistiqueJournalierEmployeBarGrandModele();
    }

    if (nbre_vente_credit > 0 &&
        nbre_vente_produit > 0 &&
        nbre_vente_tee_shirt <= 0) {
      return StatistiqueJournalierEmployeBarCreditPetitModele();
    }

    if (nbre_vente_credit > 0 &&
        nbre_vente_produit <= 0 &&
        nbre_vente_tee_shirt > 0) {
      return StatistiqueJournalierEmployeBarCreditGrandModele();
    }

    if (nbre_vente_credit <= 0 &&
        nbre_vente_produit > 0 &&
        nbre_vente_tee_shirt > 0) {
      return StatistiqueJournalierEmployeBarPetitGrandModele();
    }

    return StatistiqueJournalierGeneralEmployeBar();
  }
}
