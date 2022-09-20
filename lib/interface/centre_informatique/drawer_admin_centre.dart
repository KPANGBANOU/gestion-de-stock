// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

class DrawerAdminCentre extends StatelessWidget {
  DrawerAdminCentre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Drawer(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                    child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    _donnesUtilisateur.sexe == "Masculin"
                        ? CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.indigoAccent,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Image.asset(
                                  'images/homme.png',
                                  width: 90,
                                  height: 90,
                                  scale: 2.5,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.indigoAccent,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Image.asset(
                                  'images/femme.jpg',
                                  width: 90,
                                  height: 90,
                                  scale: 2.5,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            _donnesUtilisateur.prenom.toString() +
                                ' ' +
                                _donnesUtilisateur.nom.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                )),
              ),
              ListTile(
                title: Text(
                  "Bar restaurant".toUpperCase(),
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/bar");
                },
              ),
              ListTile(
                title: Text("Bénéfices réalisées".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centrebenefices");
                },
              ),
              ListTile(
                title: Text("Rubrique de versement".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centrerubrique");
                },
              ),
              ListTile(
                title: Text("Statistique de vente".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centrestatistiquevente");
                },
              ),
              ListTile(
                title: Text("Liquidité de crédit".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreliquiditecredit");
                },
              ),
              ListTile(
                title: Text("Etat du stock".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centrestockphysique");
                },
              ),
              ListTile(
                title: Text("Rechargement de crédits".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreapprovisionnement");
                },
              ),
              ListTile(
                title: Text("Approvisionnement".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreapprovisionnement");
                },
              ),
              ListTile(
                title: Text("Liquidité de crédit".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreliquiditecredit");
                },
              ),
              ListTile(
                title: Text("Les produits du centre".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreproduits");
                },
              ),
              ListTile(
                title: Text(
                  "Deconnexion".toUpperCase(),
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () async {
                  await _firebase.signOut();
                  Navigator.of(context).pushNamed("/login");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}