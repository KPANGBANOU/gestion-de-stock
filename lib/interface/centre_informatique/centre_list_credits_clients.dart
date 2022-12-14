// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/interface/centre_informatique/stream_credit_servant.dart';
import 'package:projet/modele/credits_servants.dart';
import 'package:provider/provider.dart';

class CentreListCreditsClientsServant extends StatelessWidget {
  const CentreListCreditsClientsServant({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_credits = Provider.of<List<CreditsServants>>(context);

    if (_list_credits.isEmpty) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Liste des crédits",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          backgroundColor: Colors.indigo,
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
        title: Text(
          "Liste des crédits",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: SizedBox(
        height: MediaQuery.of(context)
            .size
            .height, //MediaQuery.of(context).size.height,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: ((context, index) {
              CreditsServants _donnes = _list_credits[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamCreditClient(credit_uid: _donnes.uid))));
                },
                leading: Image.asset(
                  "images/homme.png",
                  width: 40,
                  height: 40,
                  scale: 2.5,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  _donnes.prenom_client.toString() +
                      " " +
                      _donnes.nom_client.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("Enregistré le  : " + _donnes.date_vente),
              );
            }),
            separatorBuilder: ((context, index) => Divider(
                  color: Colors.black,
                  height: 2,
                )),
            itemCount: _list_credits.length),
      ),
    );
  }
}
