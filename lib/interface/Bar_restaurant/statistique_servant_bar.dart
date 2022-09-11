// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class StatistiqueServantBar extends StatelessWidget {
  const StatistiqueServantBar({super.key});

  @override
  Widget build(BuildContext context) {
    final _donnes_servants = Provider.of<donnesUtilisateur>(context);
    final _liste_petit_modele = Provider.of<List<ventePetitModele>>(context);
    final _liste_grand_modele = Provider.of<List<venteGrandModele>>(context);
    return Scaffold(
      drawer: servantdrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          _donnes_servants.prenom.toString() +
              " " +
              _donnes_servants.nom.toString().toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Statistique de vente de ".toUpperCase() +
                    _donnes_servants.prenom.toString().toUpperCase() +
                    " " +
                    _donnes_servants.nom.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Catégorie pétit modèle".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.indigo,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      "Produit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Quantité vendu",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Text(
                      "Montant total",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            _liste_petit_modele.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cet employé n'a vendu aucune bièrre de la catégory pétit modèle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.redAccent.withOpacity(.7),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : SingleChildScrollView(
                    child: SizedBox(
                      height: 400,
                      child: ListView.separated(
                          itemBuilder: ((context, index) {
                            ventePetitModele _donnes =
                                _liste_petit_modele[index];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    _donnes.nom_bierre,
                                    style: TextStyle(
                                        color: Colors.black12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  _donnes.quantite.toString(),
                                  style: TextStyle(
                                      color: Colors.black12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 14.0),
                                  child: Text(
                                    _donnes.montant.toString(),
                                    style: TextStyle(
                                        color: Colors.black12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            );
                          }),
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: _liste_petit_modele.length),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
