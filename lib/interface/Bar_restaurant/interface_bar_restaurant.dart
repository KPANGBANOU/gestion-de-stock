// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable, unused_field, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class Bar extends StatelessWidget {
  Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);

    final utilisateur = Provider.of<Utilisateur?>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: DrawerAdminBar(),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                showGeneralDialog(
                  barrierLabel: "Menu",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 700),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 40, left: 152, right: 12),
                        height: 200,
                        child: SizedBox.expand(
                            child: Column(
                          // ignore: prefer_const_literals_to_create_immutables

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/barsavanewproduct");
                                  },
                                  child: Text(
                                    'Nouvelle bièrre',
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/barlistebierres");
                                },
                                child: Text(
                                  'Listes des bières',
                                  style: TextStyle(color: Colors.black),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/parametresadmin");
                                },
                                child: Text(
                                  'Paramètres',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        )),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(
                Icons.more_vert_outlined,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Gestion du bar",
          style: TextStyle(
              color: Colors.white.withOpacity(.8),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text("Gestion"),
      ),
    );
  }
}
