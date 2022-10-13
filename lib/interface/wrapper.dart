// ignore_for_file: unused_local_variable, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_null_comparison, dead_code, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, prefer_final_fields, unused_field, must_be_immutable, unused_import, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, prefer_const_declarations

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/accueil.dart';
import 'package:projet/interface/centre_informatique/accueil_servant_centre.dart';
import 'package:projet/interface/home.dart';
import 'package:projet/interface/welcome.dart';
import 'package:projet/interface/welcome_default.dart';
import 'package:projet/interface/welcome_servant.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/services/user.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File _file;
    final _pdf = pw.Document();
    final _cron = Cron();
    final firebase = Provider.of<Utilisateur?>(context);
    final _donnnes = Provider.of<donnesUtilisateur>(context);
    final _list_credits = Provider.of<List<credit>>(context);
    final _list_tee_shirt = Provider.of<List<serigraphie>>(context);
    final _list_bierres_petit_modele =
        Provider.of<List<donneesBieerePetitModele>>(context);
    final _list_produits_centre = Provider.of<List<products>>(context);
    final _list_bierres_grand_modele =
        Provider.of<List<donnesBierresGrandModel>>(context);
// signaler approvisonnement
    _cron.schedule(Schedule.parse('*/3 * * * *'), () async {
      _list_credits.forEach((element) {
        if (element.montant_disponible < element.seuil_approvisionnement) {
          print("approvisionnement demandé");
        }
      });

      _list_bierres_grand_modele.forEach((element) {
        if (element.quantite_physique < element.seuil_approvisionnement) {
          print("approvisionnement demandé");
        }
      });

      _list_bierres_petit_modele.forEach((element) {
        if (element.quantite_physique < element.seuil_approvisionnement) {
          print("approvisionnement demandé");
        }
      });

      _list_tee_shirt.forEach((element) {
        if (element.quantite_physique < element.seuil_approvisionnement) {
          print("approvisionnement demandé");
        }
      });
    });

    // rapport rubrique journalier

    _cron.schedule(Schedule.parse('0 20 * * *'), () async {
      print(" ok ");

      _pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [],
          );
        },
      ));
      final _file1 = File('rapports/rapport_journalier.pdf');
      await _file1.writeAsBytes(await _pdf.save());
      final String path = 'rapports/rapport_journalier.pdf';

      await WhatsappShare.shareFile(
        text: 'Bonsoir Monsieur! Voici le rapport journalier des ventes',
        filePath: [path],
        phone: '22997392026',
      );
    });

    // rapport hebdomendaire await _file1.writeAsBytes( await _pdf.save())
    _cron.schedule(Schedule.parse('10 20 * * 0'), () async {
      print(" ok ");
      _pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                height: 10,
              ),
              pw.Text("Rapprthebdomendaire de vente ".toUpperCase(),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 22,
                      color: PdfColors.black))
            ],
          );
        },
      ));
      final _file2 = File('rapports/rapport_hebdomendaire.pdf');
      await _file2.writeAsBytes(await _pdf.save());

      final String path = 'rapports/rapport_hebdomendaire.pdf';

      await WhatsappShare.shareFile(
        text: 'Bonsoir Monsieur! Voici le rapport hebdomendaire  des ventes',
        filePath: [path],
        phone: '22997392026',
      );
    });

    // rapport mensuel

    _cron.schedule(Schedule.parse('0 20 1 * *'), () async {
      print(" ok ");

      _pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [],
          );
        },
      ));
      final _file3 = File('rapports/rapport_mensuel.pdf');
      await _file3.writeAsBytes(await _pdf.save());

      final String path = 'rapports/rapport_mensuel.pdf';

      await WhatsappShare.shareFile(
        text: 'Bonsoir Monsieur! Voici le rapport mensuel des ventes',
        filePath: [path],
        phone: '22997392026',
      );
    });

    if (firebase == null) {
      return Accueil();
    }
    if (_donnnes.is_active != true) return Welcome();
    if (_donnnes.admin == true) return HomePage();
    if (_donnnes.role == "Servant") {
      if (_donnnes.domaine == "Bar restaurant") {
        return WelcomeServantPage();
      } else if (_donnnes.domaine == "Centre informatique") {
        return AccueilServantCentre();
      } else
        return Welcome();
    }

    return Welcome();
  }
}
