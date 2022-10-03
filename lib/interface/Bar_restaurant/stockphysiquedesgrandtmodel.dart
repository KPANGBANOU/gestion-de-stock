// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:provider/provider.dart';

import 'stream_liquidite_grand_modele.dart';

class LiquiditeListGrandModele extends StatelessWidget {
  const LiquiditeListGrandModele({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_produits = Provider.of<List<donnesBierresGrandModel>>(context);

    if (_list_produits.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Liquidité de grand modèle",
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
          "Liquidité de bièrres",
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
            itemBuilder: ((context, index) {
              donnesBierresGrandModel _donnes = _list_produits[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StreamStockPhysiqueGrandModele(
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
                  _donnes.nom.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
                subtitle: Text("La quantité disponible est de : " +
                    _donnes.quantite_physique.toString()),
              );
            }),
            separatorBuilder: ((context, index) => Divider(
                  color: Colors.black,
                  height: 1,
                )),
            itemCount: _list_produits.length),
      ),
    );
  }
}
