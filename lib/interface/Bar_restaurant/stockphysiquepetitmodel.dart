// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StockPhysiquePetitModel extends StatelessWidget {
  StockPhysiquePetitModel({Key? key}) : super(key: key);

  final _bierre = FirebaseFirestore.instance.collectionGroup("bierres");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bierre
            .orderBy("nom", descending: false)
            .where("type", isEqualTo: "Pétit modèle")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                backgroundColor: Colors.indigoAccent,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  "Pétit modèle",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8), fontSize: 22),
                ),
              ),
              body: Center(
                child: Text(
                  "Une erreur inattendur s'est produite. Vérifiez votre connection et réessayer.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent.withOpacity(.7), fontSize: 25),
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                backgroundColor: Colors.indigoAccent,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  "Pétit modèle",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8), fontSize: 22),
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                backgroundColor: Colors.indigoAccent,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  "Pétit modèle",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8), fontSize: 22),
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.indigoAccent,
              title: Text(
                "Pétit modèle",
                style: TextStyle(
                    color: Colors.white.withOpacity(.8), fontSize: 22),
              ),
            ),
            body: Center(
              child: Text("Petit modele"),
            ),
          );
        });
  }
}
