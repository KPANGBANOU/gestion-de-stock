// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/accoder_droits_second_page.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class AccorderDroitsFirstPage extends StatelessWidget {
  AccorderDroitsFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<List<donnesUtilisateur>>(context);

    if (_utilisateur.isEmpty) {
      return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Informations",
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
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Aucun employè correspondant à l'email que vous avez saisi n'a ètè trouvé dans la base de donnée de cette entreprise !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent.withOpacity(.8),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: (() {}),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Réessayez s'il vous plait !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Informations",
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
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Informations relatives à l'employè".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: _utilisateur.length,
                  itemBuilder: ((context, index) {
                    donnesUtilisateur _donnes = _utilisateur[index];

                    return Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Nom :"),
                            Text(_donnes.nom.toString())
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Prénom :"),
                            Text(_donnes.prenom.toString())
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Sexe :"),
                            Text(_donnes.sexe.toString())
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Prénom :"),
                            Text(_donnes.prenom.toString())
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Téléphone :"),
                            Text(_donnes.telephone.toString())
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Né le :"),
                            Text(_donnes.date_naissance.toString())
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Compte créé le :"),
                            Text(_donnes.prenom.toString())
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Etes vous sur que c'est bien à cet employé que vous voudriez accorder de droits ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.redAccent.withOpacity(.8),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.indigo),
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            AccorderDroitsSecondPages(
                                                nom: _donnes.nom.toString(),
                                                uid: _donnes.uid,
                                                prenom:
                                                    _donnes.prenom.toString(),
                                                email: _donnes.email
                                                    .toString()))));
                              }),
                              child: Text(
                                "Continuez".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    );
                  })),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: (() {
                    Navigator.pushNamed(context, "/accorderDroits");
                  }),
                  child: Text(
                    "Annulez".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
