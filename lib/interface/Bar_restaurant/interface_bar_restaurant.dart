// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable, unused_field, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class Bar extends StatelessWidget {
  Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);
    final CollectionReference _user =
        FirebaseFirestore.instance.collection("users");
    final utilisateur = Provider.of<Utilisateur?>(context);
    return StreamBuilder(
        stream: _user.doc(utilisateur!.uid).snapshots(),
        builder: (BuildContext conttext, streamsnapshot) {
          if (streamsnapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text(
                  "Déo Gracias",
                  style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 22,
                  ),
                ),
                backgroundColor: Colors.indigoAccent,
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Une erreur inattendue s'est produite. Vrifiez votre connection et réessayer. Si le problème persiste, veuillez contactez le développeur de l'aplication et signaler le lui !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.redAccent.withOpacity(.7), fontSize: 25),
                  ),
                ),
              ),
            );
          }
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.cyanAccent,
                ),
              ),
            );
          }

          if (!streamsnapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.cyanAccent,
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.greenAccent,
            drawer: Drawer(
              width: 240,
              child: ListView(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 200,
                    child: DrawerHeader(
                        child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        (streamsnapshot.data as DocumentSnapshot)['sexe'] ==
                                "Masculin"
                            ? CircleAvatar(
                                radius: 56,
                                backgroundColor: Colors.indigoAccent,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'images/homme.png',
                                      width: 90,
                                      height: 90,
                                      scale: 2.5,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 56,
                                backgroundColor: Colors.indigoAccent,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'images/femme.jpg',
                                      width: 90,
                                      height: 90,
                                      scale: 2.5,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                (streamsnapshot.data
                                        as DocumentSnapshot)['prenom'] +
                                    ' ' +
                                    (streamsnapshot.data
                                        as DocumentSnapshot)['nom'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    )),
                  ),
                  ListTile(
                    title: Text("Bénéfices réalisées".toUpperCase()),
                    onTap: () {
                      Navigator.pushNamed(context, "/barbenefices");
                    },
                  ),
                  ListTile(
                    title: Text("Rubrique de versement".toUpperCase()),
                    onTap: () {
                      Navigator.pushNamed(context, "/barrubrique");
                    },
                  ),
                  ListTile(
                    title: Text("Statistique de vente".toUpperCase()),
                    onTap: () {
                      Navigator.pushNamed(context, "/barstatistiquedesventes");
                    },
                  ),
                  ListTile(
                    title: Text("Etat du stock".toUpperCase()),
                    onTap: () {
                      Navigator.pushNamed(context, "/barstockphysique");
                    },
                  ),
                  ListTile(
                    title: Text("Approvisionner".toUpperCase()),
                    onTap: () {
                      Navigator.pushNamed(context, "/barsavenewstock");
                    },
                  ),
                  ListTile(
                    title: Text("Deconnecter".toUpperCase()),
                    onTap: () async {
                      await _firebase.signOut();
                      Navigator.of(context).pushNamed("/login");
                    },
                  )
                ],
              ),
            ),
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
                              margin: EdgeInsets.only(
                                  top: 40, left: 152, right: 12),
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
        });

    /*
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          "Restaurant",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        /* actions: [
          TextButton(
              onPressed: () {
                showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 700),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 40, left: 152, right: 12),
                        height: 300,
                        child: SizedBox.expand(
                            child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/barsavanewproduct");
                                },
                                child: Text('Ajouter un nouveau produit')),
                            TextButton(
                                onPressed: () {
                                  
                                },
                                child: Text('Approvisionner')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/barlistebierres");
                                },
                                child: Text('Listes des bières')),
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
        ],*/
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: Colors.black.withOpacity(.7),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Etat de stock",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Rubrique de versement",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Bénéfices",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/bardepenses");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Dépenses",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/barpertes");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Pertes",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/barapprovisionnement");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Approvisionnement",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/barsuivivente");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Statistique de vente",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 40,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Voici l'état actuel du stock des bièrres par type de modèle"
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              )),
          Container(
            color: Colors.green,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, "/barstockphysiquepetitmodele");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Catégorie pétit modèle",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, "/barstockphysiquegrandmodele");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Catégorie grand modèle",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 56,
                backgroundColor: Colors.indigoAccent,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      'images/profil_homme.png',
                      width: 90,
                      height: 90,
                      scale: 2.5,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Container(
              child: Text(
                "Déo Gracias".toUpperCase() +
                    "\n" +
                    "L'Entreprise spécialisée dans plusieurs domaines." +
                    "\n" +
                    "Nous offrons des services de grande qualité. Il suffirait de nous faire un coucou",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(.8)),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavigation(),
    );*/
  }
}
