// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, must_be_immutable, unused_field, prefer_final_fields, import_of_legacy_library_into_null_safe, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/succes_accorder_droits.dart';
import 'package:smart_select/smart_select.dart';

class AccorderDroitsSecondPages extends StatelessWidget {
  AccorderDroitsSecondPages({
    Key? key,
    required this.nom,
    required this.uid,
    required this.prenom,
    required this.email,
  }) : super(key: key);
  final String nom;
  final String uid;
  final String prenom;
  final String email;
  String _value = "Centre informatique";
  List<S2Choice<String>> _options = [
    S2Choice(value: "", title: ""),
    S2Choice<String>(
        value: "Centre informatique", title: "Centre informatique"),
    S2Choice<String>(value: "Bar restaurant", title: "Bar restaurant")
  ];

  String _role = "Centre informatique";
  List<S2Choice<String>> _roles = [
    S2Choice(value: "", title: ""),
    S2Choice<String>(value: "Servant", title: "Servant"),
    S2Choice<String>(value: "Gérant", title: "Gérant")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
        title: Text(
          prenom.toString() + " " + nom.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
                "Accorder de droits d'unsage à " + prenom + " " + nom,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Quel est le role de cet employé ? ".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SmartSelect<String>.single(
              title: "Secteur de travail",
              value: _role,
              choiceItems: _roles,
              onChange: (S2SingleState<String> value) {},
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dans quel secteur cet employé doit il travailler ? "
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SmartSelect<String>.single(
              title: "Secteur de travail",
              value: _value,
              choiceItems: _options,
              onChange: (S2SingleState<String> value) {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                    onPressed: (() async {
                      try {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .update({"role": _role, "secteur_travail": _value});

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SuccesAccorderDroits(
                                    nom: nom,
                                    prenom: prenom,
                                    secteur: _value,
                                    role: _role))));
                      } catch (e) {
                        final snackar = SnackBar(
                          content: Text(
                            "Désolé! Une erreur inattendue s'est produite pendant l'opération ! Réessayez!"
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          elevation: 10,
                          margin: EdgeInsets.all(4),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackar);
                      }
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Accordez".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
