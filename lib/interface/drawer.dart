// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/parametres_admin.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

import 'comptabilite_generale.dart';

class DrawerHome extends StatelessWidget {
  DrawerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);
    final _donnesUsers = Provider.of<donnesUtilisateur>(context);

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
                          _donnesUsers.prenom.toString() +
                              " " +
                              _donnesUsers.nom.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )),
              ),
              ListTile(
                title: Text(
                  "Gestion du centre informatique".toUpperCase(),
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/centreInformatique");
                },
              ),
              ListTile(
                title: Text(
                  "Gestion du bar restaurant".toUpperCase(),
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/bar");
                },
              ),
              ListTile(
                title: Text(
                  "Comptabilit?? g??n??rale".toUpperCase(),
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ComptabiliteGenerale())));
                },
              ),
              ListTile(
                title: Text("Liste des employ??s".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/listeEmployes");
                },
              ),
              ListTile(
                title: Text("Attribution de droits".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/accorderDroits");
                },
              ),
              ListTile(
                title: Text("Param??tres".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ParametresAdmin())));
                },
              ),
              ListTile(
                title: Text(
                  "D??connexion".toUpperCase(),
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
