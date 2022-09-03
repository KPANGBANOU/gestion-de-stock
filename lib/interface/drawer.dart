// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projet/services/registration.dart';
import 'package:provider/provider.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Drawer(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 150,
                child: DrawerHeader(
                    child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/centreInformatique");
                          },
                          child: Text(
                            "CENTRE INFORMATIQUE",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/bar");
                          },
                          child: Text(
                            "BAR RESTAURANT",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ],
                )),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      "GESTION DES EMPLOYES",
                      style: TextStyle(color: Colors.black.withOpacity(.5)),
                    ),
                  )),
              ListTile(
                title: Text("Listes des employés "),
                onTap: () {
                  Navigator.pushNamed(context, "/listeEmployes");
                },
              ),
              ListTile(
                title: Text("Accorder de droits à un employé"),
                onTap: () {
                  Navigator.pushNamed(context, "/accorderDroits");
                },
              ),
              ListTile(
                title: Text("Informations de l'employé "),
                onTap: () {
                  Navigator.pushNamed(context, "/infoEmploye");
                },
              ),
              ListTile(
                title: Text("Déconnexion"),
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
