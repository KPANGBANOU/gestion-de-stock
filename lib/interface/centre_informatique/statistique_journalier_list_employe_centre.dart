// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';

import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/provider/serac.dart';
import 'package:provider/provider.dart';

import 'stream_statistique_journalier_employe_centre.dart';

class StatistiqueJournalierListEmployeCentre extends StatelessWidget {
  StatistiqueJournalierListEmployeCentre({Key? key}) : super(key: key);
  TextEditingController _search_value = TextEditingController();
  late bool affiche = false;
  @override
  Widget build(BuildContext context) {
    final _list_servants = Provider.of<List<donnesServants>>(context);
    final _search_provider = Provider.of<Search>(context);
    // ignore: curly_braces_in_flow_control_structures
    if (_list_servants.isEmpty)
      // ignore: curly_braces_in_flow_control_structures
      return Scaffold(
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          title: Text(
            "Statistique  journalier",
            style: TextStyle(
                color: Colors.white.withOpacity(.9),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    return Scaffold(
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (() {
                  affiche = _search_provider.afficher;
                }),
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 20,
                ))
          ],
          centerTitle: true,
          backgroundColor: Colors.indigo,
          title: Text(
            "Statistique journalier",
            style: TextStyle(
                color: Colors.white.withOpacity(.9),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              affiche
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                      ),
                      child: TextField(
                        controller: _search_value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Recherchez".toUpperCase(),
                          hintText: "Saisissez le nom svp !",
                          labelStyle: TextStyle(
                            color: Colors.white.withOpacity(.8),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(.7),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                    separatorBuilder: ((context, index) => Divider()),
                    itemCount: _list_servants.length,
                    itemBuilder: ((context, index) {
                      donnesServants _donnes = _list_servants[index];
                      return _search_value.text.isEmpty
                          ? ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            StreamStatistiqueJournalierEmployeCentre(
                                                uid: _donnes.uid))));
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.indigo,
                                child: ClipOval(
                                  child: Image.asset(
                                    'images/homme.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    scale: 2.5,
                                  ),
                                ),
                              ),
                              title: Text(
                                _donnes.prenom.toString() +
                                    " " +
                                    _donnes.nom.toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                "A créé son compte le",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black12),
                              ),
                            )
                          : _donnes.nom
                                      .toString()
                                      .contains(_search_value.text) ||
                                  _donnes.prenom
                                      .toString()
                                      .contains(_search_value.text)
                              ? ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                StreamStatistiqueJournalierEmployeCentre(
                                                    uid: _donnes.uid))));
                                  },
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.indigo,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'images/homme.png',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        scale: 2.5,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _donnes.prenom.toString() +
                                        " " +
                                        _donnes.nom.toString().toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "A créé son compte le",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black12),
                                  ),
                                )
                              : Container();
                    })),
              ),
            ],
          ),
        ));
  }
}
