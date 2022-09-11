// ignore_for_file: prefer_const_constructors, unused_local_variable, must_be_immutable, prefer_typing_uninitialized_variables, unused_field, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutabl, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class ProfilUtilisateur extends StatelessWidget {
  ProfilUtilisateur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mon profil".toUpperCase(),
          style: TextStyle(
              color: Colors.white.withOpacity(.8), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                        'images/homme.png',
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
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Nom :",
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7), fontSize: 20),
                  ),
                  Text(
                    _donnesUtilisateur.nom.toString(),
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Prénom :",
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7), fontSize: 20),
                  ),
                  Text(
                    _donnesUtilisateur.prenom.toString(),
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email :",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.7), fontSize: 17),
                    ),
                    Text(
                      _donnesUtilisateur.email.toString(),
                      style: TextStyle(
                        color: Colors.black12,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Téléphone :",
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7), fontSize: 17),
                  ),
                  Text(
                    _donnesUtilisateur.telephone.toString(),
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 70, left: 10.0, right: 10, bottom: 70),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  color: Colors.indigo,
                  child: TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              backgroundColor: Colors.indigo,
                              fontWeight: FontWeight.bold)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mettre à jour".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
