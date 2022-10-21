// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_local_variable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';
import 'package:projet/interface/info_utilisateur.dart';
import 'package:projet/provider/serac.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class ListeUtilisateurs extends StatelessWidget {
  ListeUtilisateurs({Key? key}) : super(key: key);

  TextEditingController _search_value = TextEditingController();
  late bool affiche = false;

  @override
  Widget build(BuildContext context) {
    final _list_employes = Provider.of<List<donnesUtilisateur>>(context);
    final _search_provider = Provider.of<Search>(context);

    if (_list_employes.isEmpty) {
      return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Liste des employés",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      drawer: Drawer(),
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
          "Liste des employés",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
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
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: ((context, index) {
                    donnesUtilisateur _donnes = _list_employes[index];
                    return _search_value.text.isEmpty
                        ? ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          InformationsUtilisateur(
                                              nom: _donnes.nom.toString(),
                                              prenom: _donnes.prenom.toString(),
                                              sexe: _donnes.sexe.toString(),
                                              date_naissance: _donnes
                                                  .date_naissance
                                                  .toString(),
                                              email: _donnes.email.toString(),
                                              role: _donnes.role.toString(),
                                              uid: _donnes.uid,
                                              telephone:
                                                  _donnes.telephone.toString(),
                                              secteur_travail:
                                                  _donnes.nom.toString()))));
                            },
                            leading: Image.asset(
                              "images/homme.png",
                              width: 50,
                              height: 50,
                              scale: 2.5,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              _donnes.prenom.toString() +
                                  " " +
                                  _donnes.nom.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "A créé son compte le : " +
                                  _donnes.role.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : _donnes.nom.toString().contains(_search_value.text) ||
                                _donnes.prenom
                                    .toString()
                                    .contains(_search_value.text)
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              InformationsUtilisateur(
                                                  nom: _donnes.nom.toString(),
                                                  prenom:
                                                      _donnes.prenom.toString(),
                                                  sexe: _donnes.sexe.toString(),
                                                  date_naissance: _donnes
                                                      .date_naissance
                                                      .toString(),
                                                  email:
                                                      _donnes.email.toString(),
                                                  role: _donnes.role.toString(),
                                                  uid: _donnes.uid,
                                                  telephone: _donnes.telephone
                                                      .toString(),
                                                  secteur_travail: _donnes.nom
                                                      .toString()))));
                                },
                                leading: Image.asset(
                                  "images/homme.png",
                                  width: 50,
                                  height: 50,
                                  scale: 2.5,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  _donnes.prenom.toString() +
                                      " " +
                                      _donnes.nom.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "A créé son compte le : " +
                                      _donnes.role.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container();
                  }),
                  separatorBuilder: ((context, index) => Divider()),
                  itemCount: _list_employes.length),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
