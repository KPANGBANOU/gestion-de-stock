// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/interface/centre_informatique/stream_liquidite_credit.dart';
import 'package:projet/interface/centre_informatique/stream_update_reseau_credit.dart';
import 'package:projet/modele/credit.dart';

import 'package:provider/provider.dart';

class CentreListCredits extends StatelessWidget {
  const CentreListCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_credits = Provider.of<List<credit>>(context);

    if (_list_credits.isEmpty) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Liste de crédits",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.cyanAccent,
          ),
        ),
      );
    }

    return Scaffold(
      drawer: CentreServantdrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Liste de crédits",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.separated(
              itemBuilder: ((context, index) {
                credit _donnes = _list_credits[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => StreamLiquiditeCredit(
                                credit_uid: _donnes.uid))));
                  },
                  leading: Image.asset(
                    "images/homme.png",
                    width: 40,
                    height: 40,
                    scale: 2.5,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    _donnes.nom,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: TextButton(
                      onPressed: (() {
                        showBottomSheet(
                            context: context,
                            builder: ((context) {
                              return Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Container(
                                  color: Colors.white,
                                  width: double.infinity,
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Etes vous vraiment sur de vouloir supprimer ce réseau de la base de donnée ?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.redAccent
                                                .withOpacity(.7),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          TextButton(
                                              onPressed: (() {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            CentreListCredits())));
                                              }),
                                              child: Text(
                                                "Anuler",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              )),
                                          TextButton(
                                              onPressed: (() async {
                                                try {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          "reseaux_communication")
                                                      .doc(_donnes.uid)
                                                      .delete();

                                                  final snakbar = SnackBar(
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Le réseau " +
                                                            _donnes.nom +
                                                            " a été supprimé avec succès de la base de donnée",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        Colors.indigo,
                                                    elevation: 10,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(5),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snakbar);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              CentreListCredits())));
                                                  // ignore: empty_catches
                                                } catch (e) {
                                                  final snakbar = SnackBar(
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Une erreur inattendue s'est produite pendant la suppression de ce réseau. Vérifiez votre connection internet et réessayez ! !",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    backgroundColor: Colors
                                                        .redAccent
                                                        .withOpacity(.8),
                                                    elevation: 10,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(5),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snakbar);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              CentreListCredits())));
                                                }
                                              }),
                                              child: Text(
                                                "Confirmer",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }));
                      }),
                      child: Icon(
                        Icons.delete,
                        color: Colors.black,
                      )),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Montant disponible : " +
                            _donnes.montant_disponible.toString(),
                        style: TextStyle(color: Colors.black.withOpacity(.5)),
                      ),
                      TextButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => StreamUpdateCredit(
                                        credit_uid: _donnes.uid))));
                          }),
                          child: Icon(
                            Icons.update,
                            color: Colors.black,
                          ))
                    ],
                  ),
                );
              }),
              separatorBuilder: ((context, index) => Divider(
                    color: Colors.black,
                    height: 2,
                  )),
              itemCount: _list_credits.length),
        ),
      ),
    );
  }
}
