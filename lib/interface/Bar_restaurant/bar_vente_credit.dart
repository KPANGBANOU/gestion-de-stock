// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, must_be_immutable, unused_field, prefer_final_fields, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/modele/budgetBar.dart';

import 'package:projet/modele/credit.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'bar_facture_vente_credit.dart';

class BarVenteCredit extends StatelessWidget {
  BarVenteCredit({super.key});

  TextEditingController _montant = TextEditingController();
  int montant = 0;
  late int montant_disponible = 0;

  @override
  Widget build(BuildContext context) {
    final _credit = Provider.of<credit>(context);
    final _budget_bar = Provider.of<BudgetBar>(context);
    final _donnes = Provider.of<donnesUtilisateur>(context);

    if (_credit == null) {
      return Scaffold(
        drawer: CentreServantdrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Crédit",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.greenAccent,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: servantdrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          _credit.nom,
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Enregistrement de vente de ".toUpperCase() +
                    _credit.nom.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Renseignez bien les informations rélatives à la vente svp "
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(.7),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _montant,
                  decoration: InputDecoration(
                      hintText: "Saisissez le montant",
                      labelText: "Montant de vente".toUpperCase()),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        textStyle: TextStyle(backgroundColor: Colors.indigo)),
                    // ignore: sort_child_properties_last
                    child: Text(
                      "Enregistrez la vente".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: (() async {
                      try {
                        montant = int.parse(_montant.text);
                        if (montant > _credit.montant_disponible) {
                          final snack = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Le stock est insuffisant. Vérifiez diminuer le montant de vente et réessayez !!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            backgroundColor: Colors.redAccent.withOpacity(.8),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(4),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        } else {
                          await FirebaseFirestore.instance
                              .collection("vente_credits")
                              .add({
                            'produit_uid': _credit.uid,
                            'user_uid': _donnes.uid,
                            'user_nom': _donnes.nom,
                            'user_prenom': _donnes.prenom,
                            "nom": _credit.nom,
                            "montant": montant,
                            "derniere_vente": DateTime.now()
                          });

                          await FirebaseFirestore.instance
                              .collection("budget")
                              .doc(_budget_bar.uid)
                              .update({
                            "benefice": _budget_bar.benefice +
                                (montant * _credit.benefice_sur_5000) / 5000,
                            "solde_total": _budget_bar.solde_total + montant,
                          });

                          await FirebaseFirestore.instance
                              .collection("reseaux_communication")
                              .doc(_credit.uid)
                              .update({
                            "montant_disponible":
                                _credit.montant_disponible - montant,
                            "benefice":
                                (montant * _credit.benefice_sur_5000) / 5000,
                          });

                          _montant.clear();

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => FactureVenteCreditBar(
                                        credit_montant_vendu: montant,
                                        credit_uid: _credit.uid,
                                        credit_nom: _credit.nom.toString(),
                                        credit_montant_restant:
                                            _credit.montant_disponible,
                                      ))));
                        }
                        // ignore: empty_catches
                      } catch (e) {
                        final snack = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Une erreur intatte,ndue s'est produite pendant l'enregistrement de vente. Vérifier votreconnection internet et réessayez !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          backgroundColor: Colors.redAccent.withOpacity(.8),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(4),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      }
                    })),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
