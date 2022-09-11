// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, must_be_immutable, prefer_final_fields, unused_field, prefer_const_constructors_in_immutables, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/interface/Bar_restaurant/stream_vente_grand_modele.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:provider/provider.dart';

class ListeDesGrandModel extends StatelessWidget {
  ListeDesGrandModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bierre_grand_modele =
        Provider.of<List<donnesBierresGrandModel>>(context);

    if (_bierre_grand_modele.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Grand modèle".toUpperCase(),
            style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        drawer: servantdrawer(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Grand modèle".toUpperCase(),
            style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        drawer: servantdrawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _bierre_grand_modele.length,
                itemBuilder: ((context, index) {
                  donnesBierresGrandModel _donnes = _bierre_grand_modele[index];

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  StreamVenteGrandModele(uid: _donnes.uid))));
                    },
                    leading: Image.asset(
                      'images/bierres.jpeg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      scale: 2.5,
                    ),
                    title: Text(
                      _donnes.nom.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    subtitle: Text(
                      _donnes.type,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                })),
          ),
        ));
  }
}
