// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/interface/centre_informatique/stream_liquidite_credit.dart';

import 'package:projet/modele/credit.dart';
import 'package:projet/provider/serac.dart';
import 'package:provider/provider.dart';

class CentreListCredits extends StatelessWidget {
  CentreListCredits({super.key});

  TextEditingController _search_value = TextEditingController();
  late bool affihe = false;

  @override
  Widget build(BuildContext context) {
    final _list_credits = Provider.of<List<credit>>(context);
    final _search_provider = Provider.of<Search>(context);

    if (_list_credits.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Liste des crédits",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                affihe = _search_provider.afficher;
              }),
              icon: Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 20,
              ))
        ],
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Liste de crédits",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            affihe
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
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: ((context, index) {
                    credit _donnes = _list_credits[index];
                    return _search_value.text.isEmpty
                        ? ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          StreamLiquiditeCredit(
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
                              _donnes.nom.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                            subtitle: Text("Le montant disponible est de : " +
                                _donnes.montant_disponible.toString()),
                          )
                        : _donnes.nom.toString().contains(_search_value.text)
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              StreamLiquiditeCredit(
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
                                  _donnes.nom.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                ),
                                subtitle: Text(
                                    "Le montant disponible est de : " +
                                        _donnes.montant_disponible.toString()),
                              )
                            : Container();
                  }),
                  separatorBuilder: ((context, index) => Divider(
                        color: Colors.black,
                      )),
                  itemCount: _list_credits.length),
            ),
          ],
        ),
      ),
    );
  }
}
