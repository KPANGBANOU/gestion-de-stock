// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/interface/centre_informatique/streamstatistitique.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class CentreStatistiqueVente extends StatelessWidget {
  const CentreStatistiqueVente({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_employes = Provider.of<List<donnesUtilisateur>>(context);

    if (_list_employes.isEmpty) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Vente de crédits"),
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
      drawer: CentreServantdrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.separated(
              itemBuilder: ((context, index) {
                donnesUtilisateur _donnes = _list_employes[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => StreamStatistiqueVente(
                                utilisateur_uid: _donnes.uid))));
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
                  subtitle: Text("Ajouté le  : " + _donnes.nom.toString()),
                );
              }),
              separatorBuilder: ((context, index) => Divider(
                    color: Colors.black,
                    height: 2,
                  )),
              itemCount: _list_employes.length),
        ),
      ),
    );
  }
}
