// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, must_be_immutable, prefer_final_fields, unused_field, prefer_const_constructors_in_immutables, non_constant_identifier_names, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/modele/bieere_petit_model.dart';

import 'package:provider/provider.dart';

import '../../provider/serac.dart';
import 'stream_vente_petit_modele.dart';

class ListPetitModele extends StatelessWidget {
  ListPetitModele({Key? key}) : super(key: key);
  TextEditingController _search_value = TextEditingController();
  late bool affiche = false;

  @override
  Widget build(BuildContext context) {
    final _bierre_petit_modele =
        Provider.of<List<donneesBieerePetitModele>>(context);
    final _search_provider = Provider.of<Search>(context);
    if (_bierre_petit_modele.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Liste des pétits modèles",
            style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
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
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Liste des pétits modèles",
            style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        drawer: DrawerAdminBar(),
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
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    separatorBuilder: ((context, index) => Divider()),
                    itemCount: _bierre_petit_modele.length,
                    itemBuilder: ((context, index) {
                      donneesBieerePetitModele _donnes =
                          _bierre_petit_modele[index];

                      return _search_value.text.isEmpty
                          ? ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            StreamVentePetitModele(
                                                uid: _donnes.uid))));
                              },
                              leading: Image.asset(
                                'images/bierres.jpeg',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                scale: 2.5,
                              ),
                              title: Text(
                                _donnes.nom.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                "La quantité disponible est de : " +
                                    _donnes.quantite_physique.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : _donnes.nom.toString().contains(_search_value.text)
                              ? ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                StreamVentePetitModele(
                                                    uid: _donnes.uid))));
                                  },
                                  leading: Image.asset(
                                    'images/bierres.jpeg',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    scale: 2.5,
                                  ),
                                  title: Text(
                                    _donnes.nom.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "La quantité disponible est de : " +
                                        _donnes.quantite_physique.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
