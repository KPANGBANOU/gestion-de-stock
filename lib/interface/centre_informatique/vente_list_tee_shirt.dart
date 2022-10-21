// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/provider/serac.dart';
import 'package:provider/provider.dart';

import 'stream_vente_tee_shirt.dart';

class VenteListTeeShirt extends StatelessWidget {
  VenteListTeeShirt({super.key});

  TextEditingController _search_value = TextEditingController();
  late bool affiche = false;

  @override
  Widget build(BuildContext context) {
    final _list_tee_shirts = Provider.of<List<serigraphie>>(context);
    final _search_provider = Provider.of<Search>(context);

    if (_list_tee_shirts.isEmpty) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Tee shirts",
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
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Réchargement",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: ((context, index) {
                    serigraphie _donnes = _list_tee_shirts[index];
                    return _search_value.text.isEmpty
                        ? ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          StreamVenteTeeShirt(
                                              tee_shirt_uid: _donnes.uid))));
                            },
                            leading: Image.asset(
                              "images/homme.png",
                              width: 40,
                              height: 40,
                              scale: 2.5,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              _donnes.tee_shirt_nom.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                            subtitle: Text("La quantité disponible est: " +
                                _donnes.quantite_physique.toString()),
                          )
                        : _donnes.tee_shirt_nom
                                .toString()
                                .contains(_search_value.text)
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              StreamVenteTeeShirt(
                                                  tee_shirt_uid:
                                                      _donnes.uid))));
                                },
                                leading: Image.asset(
                                  "images/homme.png",
                                  width: 40,
                                  height: 40,
                                  scale: 2.5,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  _donnes.tee_shirt_nom.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                ),
                                subtitle: Text("La quantité disponible est: " +
                                    _donnes.quantite_physique.toString()),
                              )
                            : Container();
                  }),
                  separatorBuilder: ((context, index) => Divider(
                        color: Colors.black,
                        height: 2,
                      )),
                  itemCount: _list_tee_shirts.length),
            ),
          ],
        ),
      ),
    );
  }
}
