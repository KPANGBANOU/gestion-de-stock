// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, must_be_immutable, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/drawer.dart';
import 'package:projet/services/admin.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class ModifierEmailRapport extends StatelessWidget {
  ModifierEmailRapport({super.key});

  TextEditingController last_email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController new_email = TextEditingController();

  late String admin_email = "";
  late String my_password = "";
  late String mdp_crypt = "";

  @override
  Widget build(BuildContext context) {
    final _admins = Provider.of<List<Admin>>(context);
    final _user = Provider.of<donnesUtilisateur>(context);
    Admin _admin = _admins.first;
    admin_email = _admin.email_reception_rapport;
    my_password = _user.mdp;
    if (_admins.isEmpty) {
      return Scaffold(
        drawer: DrawerHome(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Email de réception",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
    return Scaffold(
      drawer: DrawerHome(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Email de réception",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Email de reception de rapport journalier, hebdomendaire et mensuel de vente générale de l'entreprise"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Renseignez bien les champs et aussi un email fonctionnel svp !"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    letterSpacing: 2,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: TextField(
                controller: last_email,
                decoration: InputDecoration(
                  labelText: "Ancien email de réception".toUpperCase(),
                  hintText: "Saisissez svp l'ancien email de réception",
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(.8),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: TextField(
                controller: new_email,
                decoration: InputDecoration(
                  labelText: "Nouveau email".toUpperCase(),
                  hintText: "Saisissez svp le nouveau email de réception",
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(.8),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                  labelText: "Votre mot de passe".toUpperCase(),
                  hintText: "Saisissez svp votre mot de passe",
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(.8),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo, textStyle: TextStyle()),
                    onPressed: (() async {
                      try {
                        mdp_crypt = Crypt.sha256(password.text).toString();
                        if (!_user.admin || _admin.uid != _user.uid) {
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Vous n'avez pas le droit d'effectuer cette opération car vous n'etes pas administrateur ou PDG de cette entreprise",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            backgroundColor: Colors.redAccent.withOpacity(.8),
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);
                        } else {
                          if (last_email.text.isEmpty ||
                              new_email.text.isEmpty ||
                              password.text.isEmpty ||
                              !last_email.text.contains('@') ||
                              !new_email.text.contains('@')) {
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Tous les champs n'ont pas été renseigné ou les emails saisis sont incorrectes !",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.redAccent.withOpacity(.8),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakbar);
                          } else {
                            if (last_email != _admin.email_reception_rapport ||
                                _user.mdp != mdp_crypt) {
                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Le mot de passe ou l'ancien email saisis est incorrecte. Veuillez réessayez !",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                backgroundColor:
                                    Colors.redAccent.withOpacity(.8),
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            } else {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(_user.uid)
                                  .update({
                                "email_reception_rapport": new_email.text
                              });

                              last_email.clear();
                              new_email.clear();
                              password.clear();

                              final snakbar = SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "L'email de réception de rapport journalier, hebdomendaire et mensuel de vente a été modifié avec succès !",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                backgroundColor: Colors.indigo,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snakbar);
                            }
                          }
                        }
                      } catch (e) {
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Une erreur inattendue s'est produite. Vérifiez votre connection internet et réessayez ! !",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.redAccent.withOpacity(.8),
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      }
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        "Modifiez".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
