// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_final_fields, unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/credits_servants.dart';
import 'package:projet/provider/serac.dart';
import 'package:provider/provider.dart';

import 'stream_credit_employe_centre.dart';

class ListVenteCreditsEmployeCentre extends StatelessWidget {
  ListVenteCreditsEmployeCentre({super.key});

  TextEditingController _search_value = TextEditingController();
  late bool affiche = false;

  @override
  Widget build(BuildContext context) {
    final _list_credits = Provider.of<List<CreditsServants>>(context);
    final _search_provider = Provider.of<Search>(context);

    if (_list_credits.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminCentre(),
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
      drawer: DrawerAdminCentre(),
      backgroundColor: Colors.greenAccent,
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
        title: Text(
          "Liste des crédits",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
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
              height: MediaQuery.of(context)
                  .size
                  .height, //MediaQuery.of(context).size.height,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: ((context, index) {
                    CreditsServants _donnes = _list_credits[index];
                    return _search_value.text.isEmpty
                        ? ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          StreamCreditEmployeCentre(
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
                              _donnes.prenom_servant.toString() +
                                  " " +
                                  _donnes.nom_servant.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                Text("Enregistré le  : " + _donnes.date_vente),
                          )
                        : _donnes.nom_client
                                    .toString()
                                    .contains(_search_value.text) ||
                                _donnes.description
                                    .toString()
                                    .contains(_search_value.text) ||
                                _donnes.nom_servant
                                    .toString()
                                    .contains(_search_value.text) ||
                                _donnes.prenom_servant
                                    .toString()
                                    .contains(_search_value.text)
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              StreamCreditEmployeCentre(
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
                                  _donnes.prenom_servant.toString() +
                                      " " +
                                      _donnes.nom_servant.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                    "Enregistré le  : " + _donnes.date_vente),
                              )
                            : Container();
                  }),
                  separatorBuilder: ((context, index) => Divider(
                        color: Colors.black,
                        height: 1,
                      )),
                  itemCount: _list_credits.length),
            ),
          ],
        ),
      ),
    );
  }
}
