// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/interface/profil.dart';

import 'modifier_password_servant_centre.dart';

class ParametreServantCentre extends StatelessWidget {
  const ParametreServantCentre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Pramètres",
            style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigoAccent,
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
                  "Pramètres d'usage du logiciel ".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, textStyle: TextStyle()),
                onPressed: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Profil())));
                }),
                child: Text(
                  "Modifier votre profil",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, textStyle: TextStyle()),
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ModifierPasswordServantCentre())));
                }),
                child: Text(
                  "Modifier votre mot de passe",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ));
  }
}
