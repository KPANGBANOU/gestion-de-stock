// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:provider/provider.dart';

class CentreStatistiqueEmploye extends StatelessWidget {
  const CentreStatistiqueEmploye({super.key});

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesServants>(context);
    final _listVente = Provider.of<List<centreVente>>(context);
    final _listVenteCredit = Provider.of<List<venteCredit>>(context);

    if (_listVente.isEmpty && _listVenteCredit.isEmpty) {
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
        body: ListView.separated(
            itemBuilder: ((context, index) {
              centreVente _vente_produits = _listVente[index];

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(_vente_produits.nom_produit),
                  Text(_vente_produits.quantite.toString()),
                  Text(_vente_produits.montant.toString()),
                  Text(_vente_produits.nom_produit)
                ],
              );
            }),
            separatorBuilder: ((context, index) => Divider()),
            itemCount: _listVente.length),
      );
    }

    if (_listVente.isEmpty && _listVenteCredit.isNotEmpty) {
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
        body: ListView.separated(
            itemBuilder: ((context, index) {
              venteCredit _vente_credit = _listVenteCredit[index];

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(_vente_credit.nom),
                  Text(_vente_credit.montant.toString()),
                  Text(_vente_credit.nom)
                ],
              );
            }),
            separatorBuilder: ((context, index) => Divider()),
            itemCount: _listVenteCredit.length),
      );
    }

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
                      _donnesUtilisateur.prenom.toString() +
                          " " +
                          _donnesUtilisateur.nom.toString(),
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
                ])));
  }
}
