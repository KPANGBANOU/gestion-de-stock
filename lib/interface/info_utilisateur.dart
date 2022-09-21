// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'accoder_droits_second_page.dart';

class InformationsUtilisateur extends StatelessWidget {
  InformationsUtilisateur({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.date_naissance,
    required this.email,
    required this.role,
    required this.uid,
    required this.telephone,
    required this.secteur_travail,
  }) : super(key: key);

  final String nom;
  final String prenom;
  final String sexe;
  final String date_naissance;
  final String email;
  final String role;
  final String uid;
  final String telephone;
  final String secteur_travail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
        title: Text(
          prenom.toString() + " " + nom.toString(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: Image.asset(
          "images/homme.png",
          width: 40,
          height: 40,
          scale: 2.5,
          fit: BoxFit.cover,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "informations rélatives à cet utilisateur".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent.withOpacity(.8),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("Nom :"), Text(nom.toString())],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("Prénom :"), Text(prenom.toString())],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("Sexe :"), Text(sexe.toString())],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("Né le :"), Text(date_naissance.toString())],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("Email :"), Text(email.toString())],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("Contact :"), Text(telephone.toString())],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("A créé son compte le :"), Text(nom.toString())],
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(.8)),
                  onPressed: (() {}),
                  child: Text(
                    "Dsactivez son compte".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(.8)),
                  onPressed: (() {}),
                  child: Text(
                    "Supprimez son compte".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AccorderDroitsSecondPages(
                                nom: nom.toString(),
                                uid: uid,
                                prenom: prenom.toString(),
                                email: email.toString()))));
                  }),
                  child: Text(
                    "Accordez lui de droits".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: (() {}),
                  child: Text(
                    "Listes des utilisateurs".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
