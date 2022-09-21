// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, dead_code, unused_local_variable, no_leading_underscores_for_local_identifiers, sort_child_properties_last, deprecated_member_use, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, avoid_init_to_null, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks, unnecessary_this

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

import 'package:projet/modele/bierre_grand_model.dart';

class BarApprovisionnerGrandModele extends StatelessWidget {
  BarApprovisionnerGrandModele({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().bierreGrandModele(this.id)),
            initialData: donnesBierresGrandModel(
                prix_unitaire: 0,
                quantite_initial: 0,
                quantite_physique: 0,
                seuil_approvisionnement: 0,
                nom: "",
                type: "Grand modèle",
                uid: this.id))
      ],
      // child: ApprovisionnerGrandModele(),
    );
  }
}
