// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/interface/centre_informatique/stream_approvisionner_credit.dart';
import 'package:projet/modele/credit.dart';
import 'package:provider/provider.dart';

class CentreApprovisionnerListReseauxCredit extends StatelessWidget {
  const CentreApprovisionnerListReseauxCredit({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_credits = Provider.of<List<credit>>(context);

    if (_list_credits.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Réchargement de crédits",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigo,
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
        title: Text(
          "Réchargement de crédits",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.separated(
              itemBuilder: ((context, index) {
                credit _donnes = _list_credits[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => StreamApprovisionnerCredit(
                                credit_uid: _donnes.uid))));
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
                  subtitle: Text("Le montant disponible est de : " +
                      _donnes.montant_disponible.toString()),
                );
              }),
              separatorBuilder: ((context, index) => Divider(
                    color: Colors.black,
                    height: 2,
                  )),
              itemCount: _list_credits.length),
        ),
      ),
    );
  }
}
