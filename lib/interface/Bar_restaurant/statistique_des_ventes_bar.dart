// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatistiqueDesVentesBar extends StatelessWidget {
  StatistiqueDesVentesBar({Key? key}) : super(key: key);

  final _servants = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _servants.where("role", isEqualTo: "Servant").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.indigoAccent,
                title: Text(
                  "Statistique vente",
                  style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                  ),
                ),
                elevation: 0,
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Une erreur inattendue s'est produite! Vérifiez votre connection et réessayer!"
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.redAccent.withOpacity(.7),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.indigoAccent,
                title: Text(
                  "Statistique vente",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8), fontSize: 22),
                ),
                elevation: 0,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.indigoAccent,
                title: Text(
                  "Statistique vente",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8), fontSize: 22),
                ),
                elevation: 0,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.greenAccent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.indigoAccent,
              title: Text(
                "Statistique vente",
                style: TextStyle(
                    color: Colors.white.withOpacity(.8), fontSize: 22),
              ),
              elevation: 0,
            ),
            body: Center(
              child: Text("Rubrique de versement"),
            ),
          );
        });
  }
}
