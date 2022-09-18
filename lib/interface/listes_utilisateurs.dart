// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_local_variable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';
import 'package:projet/interface/info_utilisateur.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class ListeUtilisateurs extends StatelessWidget {
  ListeUtilisateurs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _list_employes = Provider.of<List<donnesUtilisateur>>(context);

    if (_list_employes.isEmpty) {
      return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Liste des employés",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        body: Center(
          child: Text(
            "Il n'y a aucun employé enregistré dans la base  de données de cette entreprise"
                .toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.redAccent.withOpacity(.8),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Liste des employés",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) {
            donnesUtilisateur _donnes = _list_employes[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => InformationsUtilisateur(
                            nom: _donnes.nom.toString(),
                            prenom: _donnes.prenom.toString(),
                            sexe: _donnes.sexe.toString(),
                            date_naissance: _donnes.date_naissance.toString(),
                            email: _donnes.email.toString(),
                            role: _donnes.role.toString(),
                            uid: _donnes.uid,
                            telephone: _donnes.telephone.toString(),
                            secteur_travail: _donnes.nom.toString()))));
              },
              onLongPress: () {},
              leading: Image.asset(
                "images/homme.png",
                width: 50,
                height: 50,
                scale: 2.5,
                fit: BoxFit.cover,
              ),
              title: Text(
                _donnes.prenom.toString() + " " + _donnes.nom.toString(),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _donnes.role.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: _list_employes.length),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
