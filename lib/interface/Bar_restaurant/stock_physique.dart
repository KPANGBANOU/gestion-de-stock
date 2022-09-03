// ignore_for_file: prefer_const_constructors, dead_code, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StockPhysique extends StatelessWidget {
  StockPhysique({Key? key}) : super(key: key);

  final _bierres = FirebaseFirestore.instance.collection('bierres').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _bierres,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          if (streamsnapshot.hasError)
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text(
                  "Etat de stock",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.indigoAccent,
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Une erreur inattendue s'est produite. Vérifiez votre connection internet réessayez. Si le problème persiste, contactez le développeur de l'application et signaler le luin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent.withOpacity(.7),
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            );
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                backgroundColor: Colors.greenAccent,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    "Etat de stock",
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.indigoAccent,
                ),
                body: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      )),
                ));
          }
          if (!streamsnapshot.hasData) {
            return Scaffold(
                backgroundColor: Colors.greenAccent,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    "Etat de stock",
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.indigo,
                ),
                body: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      )),
                ));
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Text(
                "Stock pétit modèle",
                style: TextStyle(
                    color: Colors.white.withOpacity(.8), fontSize: 20),
              ),
              backgroundColor: Colors.indigo,
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children:
                  streamsnapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data['nom'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['quantite_initial'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${int.parse(data['quantite_initial']) - int.parse(data['quantite_physique'])}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['quantite_physique'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.black.withOpacity(.2),
                    )
                  ],
                );
              }).toList(),
            ),
          );
        });
  }
}
