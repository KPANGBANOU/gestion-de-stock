// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/vente.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class CentreStatistiqueEmploye extends StatelessWidget {
  const CentreStatistiqueEmploye({super.key});

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _listVente = Provider.of<List<vente>>(context);
    final _listVenteCredit = Provider.of<List<centreVente>>(context);
    return Scaffold(
      drawer: DrawerAdminCentre(),
      appBar: AppBar(
        title: Text(
          _donnesUtilisateur.prenom.toString(),
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
                    " " +
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Nom"),
                Text("Montant vendu"),
                Text("Dernière vente")
              ],
            ),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView.separated(
                    itemBuilder: ((context, index) {
                      centreVente _creditvendu = _listVenteCredit[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            _creditvendu.nom_produit,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _creditvendu.montant.toString() + " F",
                            style: TextStyle(color: Colors.black12),
                          ),
                          Text(
                            _creditvendu.montant.toString(),
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      );
                    }),
                    separatorBuilder: ((context, index) => Divider(
                          height: 2,
                          color: Colors.black,
                        )),
                    itemCount: _listVenteCredit.length),
              ),
            ),
            Text(
              "Vente d'autres produits".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
