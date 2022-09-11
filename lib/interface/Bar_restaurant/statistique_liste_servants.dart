// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/modele/donnesServants.dart';
import 'package:provider/provider.dart';

import 'stream_statistique_servant_bar.dart';

class StatistiqueListeServantsBar extends StatelessWidget {
  StatistiqueListeServantsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _list_servants = Provider.of<List<donnesServants>>(context);
    // ignore: curly_braces_in_flow_control_structures
    if (_list_servants.isEmpty)
      // ignore: curly_braces_in_flow_control_structures
      return Scaffold(
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          title: Text(
            "Statistique de vente",
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
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          title: Text(
            "Statistique de vente",
            style: TextStyle(
                color: Colors.white.withOpacity(.9),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.99,
            child: ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _list_servants.length,
                itemBuilder: ((context, index) {
                  donnesServants _donnes = _list_servants[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  StreamServantBar(uid: _donnes.uid))));
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
                      _donnes.role.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black12),
                    ),
                  );
                })),
          ),
        ));
  }
}
