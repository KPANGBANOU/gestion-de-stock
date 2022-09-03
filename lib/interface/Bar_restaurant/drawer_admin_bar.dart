// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:projet/services/registration.dart';

import 'package:provider/provider.dart';

class DrawerAdminBar extends StatelessWidget {
  DrawerAdminBar({Key? key}) : super(key: key);

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
                height: 200,
                child: DrawerHeader(
                    child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Image.asset(
                      'images/homme.png',
                      width: 90,
                      height: 90,
                      scale: 2.5,
                      fit: BoxFit.contain,
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "Marcellin",
                          textAlign: TextAlign.center,
                        ))
                  ],
                )),
              ),
              ListTile(
                title: Text("Vente de petit moèle".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/listeEmployes");
                },
              ),
              ListTile(
                title: Text("vente de grand moèle".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/accorderDroits");
                },
              ),
              ListTile(
                title: Text("Enregistrer une dépense".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/infoEmploye");
                },
              ),
              ListTile(
                title: Text("Signaler un problème".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/infoEmploye");
                },
              ),
              ListTile(
                title: Text("Mon profil".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/infoEmploye");
                },
              ),
              ListTile(
                title: Text("Me déconnecter".toUpperCase()),
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
