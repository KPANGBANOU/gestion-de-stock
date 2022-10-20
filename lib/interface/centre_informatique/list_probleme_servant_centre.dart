// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';

import 'package:projet/modele/probleme_centre.dart';

import 'package:provider/provider.dart';

import 'stream_probleme_servant_centre.dart';

class ListProblemeServantCentre extends StatelessWidget {
  const ListProblemeServantCentre({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_depenses = Provider.of<List<problemeCentre>>(context);

    if (_list_depenses.isEmpty) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Mes difficultés",
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
          "Mes difficultés",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: ((context, index) {
              problemeCentre _donnes = _list_depenses[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StreamProblemeServantCentre(
                              depense_uid: _donnes.uid))));
                },
                title: Text(
                  _donnes.description.substring(0, 200),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
                subtitle: Text("Enrégistré depuis le : " + _donnes.date),
              );
            }),
            separatorBuilder: ((context, index) => Divider(
                  color: Colors.black,
                  height: 2,
                )),
            itemCount: _list_depenses.length),
      ),
    );
  }
}