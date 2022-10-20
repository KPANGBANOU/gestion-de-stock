// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:projet/interface/drawer.dart';
import 'package:projet/modele/budgetBar.dart';
import 'package:projet/modele/budget_centre.dart';
import 'package:provider/provider.dart';

class ComptabiliteGenerale extends StatelessWidget {
  ComptabiliteGenerale({super.key});

  late int total_vente = 0;
  late int total_depense = 0;
  late int total_benefice = 0;
  late int perte_realisee = 0;
  late int benefice_brute = 0;

  @override
  Widget build(BuildContext context) {
    final _budget_bar = Provider.of<BudgetBar>(context);
    final _budget_centre = Provider.of<budgetCentre>(context);
    total_vente = _budget_centre.solde_total + _budget_bar.solde_total;
    total_benefice = _budget_centre.benefice + _budget_bar.benefice;
    total_depense = _budget_centre.depense + _budget_bar.depense;

    if (total_benefice < total_depense) {
      benefice_brute = 0;
      perte_realisee = total_depense - total_benefice;
    } else {
      perte_realisee = 0;
      benefice_brute = total_benefice - total_depense;
    }

    return Scaffold(
      drawer: DrawerHome(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Comptabilité générale",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Comptabilité générale de l'entreprise".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Container(
                  color: Colors.indigo,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Montant total vente",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        total_vente.toString() + " F",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.redAccent.withOpacity(.7),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Total dépense",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        total_depense.toString() + " F",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.redAccent.withOpacity(.7),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Pertes réalisées",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        perte_realisee.toString() + " F",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.indigo,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Bénéfice brute réalisé",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        benefice_brute.toString() + " F",
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
