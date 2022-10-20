// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/approvisionnement_list_petit_modele.dart';
import 'package:projet/interface/Bar_restaurant/approvisonnement_list_grand_modele.dart';
import 'package:projet/interface/Bar_restaurant/bar_rubrique_versement.dart';
import 'package:projet/interface/Bar_restaurant/enregistrer_nouvel_bierre.dart';
import 'package:projet/interface/Bar_restaurant/list_depense_employe_bar.dart';
import 'package:projet/interface/Bar_restaurant/list_problemes_employes_bar.dart';
import 'package:projet/interface/Bar_restaurant/list_vente_credits_employe_bar.dart';
import 'package:projet/interface/Bar_restaurant/stockphysiquedesgrandtmodel.dart';
import 'package:projet/interface/Bar_restaurant/stream_statistique_journalier_list_employe_bar.dart';
import 'package:projet/interface/Bar_restaurant/stream_statistique_list_servant_bar.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

import 'list_grand_modele.dart';
import 'list_petit_modele.dart';
import 'stockphysiquepetitmodel.dart';

class DrawerAdminBar extends StatelessWidget {
  DrawerAdminBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Drawer(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                    child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    _donnesUtilisateur.sexe == "Masculin"
                        ? CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.indigoAccent,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Image.asset(
                                  'images/homme.png',
                                  width: 90,
                                  height: 90,
                                  scale: 2.5,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.indigoAccent,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Image.asset(
                                  'images/femme.jpg',
                                  width: 90,
                                  height: 90,
                                  scale: 2.5,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            _donnesUtilisateur.prenom.toString() +
                                ' ' +
                                _donnesUtilisateur.nom.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                )),
              ),
              ListTile(
                title: Text(
                  "Centre informatique".toUpperCase(),
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/centreInformatique");
                },
              ),
              ListTile(
                title: Text("Bénéfices et pertess".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/barbenefices");
                },
              ),
              ListTile(
                title: Text("Rubrique de versement".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => BarRubriqueVersement())));
                },
              ),
              ListTile(
                title: Text("Statistique de vente".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StreamStatistiqueBar())));
                },
              ),
              ListTile(
                title: Text("Statistique journalier de vente".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamStatistiqueJournalierListEmployeBar())));
                },
              ),
              ListTile(
                title: Text("Problèmes des employés".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ListProblemeEmployesBar())));
                },
              ),
              ListTile(
                title: Text("Dépenses effectuées".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ListDepenseEmployeBar())));
                },
              ),
              ListTile(
                title: Text("Ventes à crédits enregistrées".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ListVenteCreditsEmployeBar())));
                },
              ),
              ListTile(
                title: Text("Liquidité de grand modèles".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => LiquiditeListGrandModele())));
                },
              ),
              ListTile(
                title: Text("Liquidité de pétit modèles".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => LiquiditeListPetitModele())));
                },
              ),
              ListTile(
                title: Text("Approvisionner de pétit modèle".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ApprovisionnerListPetitModele())));
                },
              ),
              ListTile(
                title: Text("Approvisionner de grand modèle".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ApprovisionnerListGrandModele())));
                },
              ),
              ListTile(
                title: Text("Liste des grand modèles".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ListGrandModele())));
                },
              ),
              ListTile(
                title: Text("Liste de pétit modèls".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ListPetitModele())));
                },
              ),
              ListTile(
                title: Text("Nouvelle bièree".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              EnregistrerNouvelBierreFormPage())));
                },
              ),
              ListTile(
                title: Text(
                  "Deconnexion".toUpperCase(),
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () async {
                  await _firebase.signOut();
                  Navigator.of(context).pushNamed("/login");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
