// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, must_be_immutable, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/approvisionnement.dart';

import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:provider/provider.dart';

class ApprovisionnementListPetitModele extends StatelessWidget {
  ApprovisionnementListPetitModele({
    Key? key,
  }) : super(key: key);

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final _list_petit_model =
        Provider.of<List<donneesBieerePetitModele>>(context);

    if (_list_petit_model.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
      );
    }

    return Scaffold(
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "DGracias App",
            style: TextStyle(
                color: Colors.white.withOpacity(.9),
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(onPressed: (() {}), icon: Icon(Icons.search)),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.indigo,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.indigo,
              width: double.infinity,
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      "Produit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Prix unitaire",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Text(
                      "Quantité physique",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("bierres")
                    .where('type', isEqualTo: 'Pétit modèle')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 148.0),
                      child: CircularProgressIndicator(),
                    );

                    // ignore: dead_code
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 148.0),
                        child: Text(
                          "Une erreur inattendue s'est produite. !"
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.redAccent.withOpacity(.7),
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.82,
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: ((context, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            var length = snapshot.data?.docs.length;
                            if (length! < 0) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: Text(
                                  "Il n'y a aucune bièrre de la catégorie pétit modèle en stock !"
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.redAccent.withOpacity(.7),
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ApprovisionnementBar(
                                                id: document.id))));
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.indigo,
                                child: ClipOval(
                                  child: Image.asset(
                                    'images/bierres.jpeg',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    scale: 2.5,
                                  ),
                                ),
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text((document.data()
                                        as Map<String, dynamic>)['nom']),
                                  ),
                                  Text((document.data() as Map)['prix_unitaire']
                                      .toString()),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text((document.data()
                                            as Map)['quantite_physique']
                                        .toString()),
                                  ),
                                ],
                              ),
                            );
                          })),
                    ),
                  );
                }))
          ],
        ));
  }
}
