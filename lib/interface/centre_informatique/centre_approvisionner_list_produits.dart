// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/interface/centre_informatique/stream_approvisionner_produit.dart';
import 'package:projet/interface/centre_informatique/stream_vente_produit.dart';

import 'package:projet/modele/produit.dart';
import 'package:provider/provider.dart';

class CentreApprovisionnerListProduits extends StatelessWidget {
  const CentreApprovisionnerListProduits({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_produits = Provider.of<List<produits>>(context);

    if (_list_produits.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Réchargement de stock",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.cyanAccent,
          ),
        ),
      );
    }

    return Scaffold(
      drawer: DrawerAdminCentre(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Réchargement de stock ",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.separated(
              itemBuilder: ((context, index) {
                produits _donnes = _list_produits[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => StreamApprovisionnerProduit(
                                produit_uid: _donnes.uid))));
                  },
                  leading: Image.asset(
                    "images/homme.png",
                    width: 40,
                    height: 40,
                    scale: 2.5,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    _donnes.nom,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                  subtitle: Text("La quantité disponible est: " +
                      _donnes.quantite_physique.toString()),
                );
              }),
              separatorBuilder: ((context, index) => Divider(
                    color: Colors.black,
                    height: 2,
                  )),
              itemCount: _list_produits.length),
        ),
      ),
    );
  }
}
