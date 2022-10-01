// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/interface/Bar_restaurant/stream_approvisionner_petit_model.dart';

import 'package:projet/modele/bieere_petit_model.dart';
import 'package:provider/provider.dart';

class ApprovisionnerListPetitModele extends StatelessWidget {
  const ApprovisionnerListPetitModele({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_products = Provider.of<List<donneesBieerePetitModele>>(context);

    if (_list_products.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Réchargement de bièrres",
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
      drawer: DrawerAdminBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Réchargement de buèrres ",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: _list_products.length,
          itemBuilder: ((context, index) {
            donneesBieerePetitModele _donnes = _list_products[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => StreamApprovisionnerPetitModele(
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
              subtitle: Text("La quantité  disponible est de : " +
                  _donnes.quantite_physique.toString()),
            );
          }),
          separatorBuilder: ((context, index) => Divider(
                color: Colors.black,
                height: 2,
              )),
        ),
      ),
    );
  }
}
