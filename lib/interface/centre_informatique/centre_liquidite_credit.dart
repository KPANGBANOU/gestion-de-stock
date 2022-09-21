// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/interface/centre_informatique/stream_approvisionner_credit.dart';
import 'package:projet/interface/centre_informatique/stream_update_reseau_credit.dart';
import 'package:projet/modele/credit.dart';
import 'package:provider/provider.dart';

class CentreLiquiditeCredit extends StatelessWidget {
  const CentreLiquiditeCredit({super.key});

  @override
  Widget build(BuildContext context) {
    final _credit = Provider.of<credit>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: DrawerAdminCentre(),
      appBar: AppBar(
        title: Text(
          _credit.nom,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
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
            Text(
              "La liquidité de ".toUpperCase() +
                  _credit.nom.toUpperCase() +
                  " disponible en stock de l'entreprise".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Montant initial :"),
                Text(_credit.montant_initial.toString() + " F")
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Montant vendu :"),
                Text((_credit.montant_initial - _credit.montant_disponible)
                        .toString() +
                    " F")
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("Montant disponible :"),
                Text(_credit.montant_disponible.toString() + " F")
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Voudriez-vous récharger le stock de ".toUpperCase() +
                  _credit.nom.toUpperCase() +
                  " ?".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.redAccent.withOpacity(.7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Réchargez le stock".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    StreamApprovisionnerCredit(
                                        credit_uid: _credit.uid))));
                      },
                    ))),
            SizedBox(
              height: 12,
            ),
            Text(
              "Voudriez-vous mettre è jour lesinformations de ".toUpperCase() +
                  _credit.nom.toUpperCase() +
                  " ?".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(backgroundColor: Colors.indigo)),
                      // ignore: sort_child_properties_last
                      child: Text(
                        "Mettre è jour".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => StreamUpdateCredit(
                                    credit_uid: _credit.uid))));
                      },
                    ))),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
