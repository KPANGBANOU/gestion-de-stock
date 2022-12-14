// ignore_for_file: unused_local_variable, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_null_comparison, dead_code, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, prefer_final_fields, unused_field, must_be_immutable, unused_import, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, prefer_const_declarations, import_of_legacy_library_into_null_safe, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:projet/interface/Bar_restaurant/accueil_servant_bar.dart';
import 'package:projet/interface/centre_informatique/vente_tee_shirt.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';
import 'package:projet/modele/vente_tee_shirts.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/accueil.dart';
import 'package:projet/interface/centre_informatique/accueil_servant_centre.dart';
import 'package:projet/interface/home.dart';
import 'package:projet/interface/welcome_default.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/services/user.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  late String _credit_nom = "";
  late int _benefice_total_credit = 0;
  late int montant_vendu_credit = 0;
  late String _current_day = DateFormat('dd').format(DateTime.now());
  late String _current_month = DateFormat('MM').format(DateTime.now());
  late String _current_vente_day = "";
  late String _current_vente_month = "";
  late int _total_vente_credit = 0;
  late int montant_total_vente_credit = 0;
  late int total_quantite_tee_shirt = 0;
  late int montant_vente_tee_shirt = 0;
  late int total_benefice_tee_shirt = 0;
  late int montant_total_vente_tee_shirt = 0;

  late int total_quantite_produits = 0;
  late int montant_vente_produits = 0;
  late int total_benefice_produits = 0;
  late int montant_total_vente_produits = 0;

  late int total_quantite_grand_modele = 0;
  late int montant_vente_grand_modele = 0;
  late int total_benefice_grand_modele = 0;
  late int montant_total_vente_grand_modele = 0;

  late int total_quantite_petit_modele = 0;
  late int montant_vente_petit_modele = 0;
  late int total_benefice_tee_petit_modele = 0;
  late int montant_total_vente_petit_modele = 0;

  late int totaux_benefice = 0;
  late int totaux_vente = 0;

  @override
  Widget build(BuildContext context) {
    final _list_vente_credits = Provider.of<List<venteCredit>>(context);
    final _list_vente_tee_shirts = Provider.of<List<venteteeshirts>>(context);
    final _list_vente_produits = Provider.of<List<centreVente>>(context);
    final _list_vente_petit_modele =
        Provider.of<List<ventePetitModele>>(context);
    final _list_vente_grand_modele =
        Provider.of<List<venteGrandModele>>(context);
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
      _list_credits.forEach((element) async {
        if (element.montant_disponible < element.seuil_approvisionnement &&
            !element.approvisionne) {
          await WhatsappShare.share(
            text: "Bonsoir Monsieur! Le r??chargement du cr??dit " +
                element.nom +
                " est r??quis. Il ne reste que " +
                element.montant_disponible.toString() +
                " F en stock de l'entreprise ",
            phone: '22997392026',
          );

          String username = 'deogracias228';
          String password = 'DEOgracias228';

          final smtpServer = gmail(username, password);
          // Use the SmtpServer class to configure an SMTP server:
          // final smtpServer = SmtpServer('smtp.domain.com');
          // See the named arguments of SmtpServer for further configuration
          // options.

          // Create our message.
          final message = Message()
            ..from = Address(username, 'D??o Gracias Entreprise')
            ..recipients.add('kpangbanoumarcellin@gmail.com')
            ..ccRecipients
            //.addAll(['destCc1@example.com', 'destCc2@example.com'])
            //..bccRecipients.add(Address('bccAddress@example.com'))
            ..subject = 'D??mande de r??chargement de stock'
            ..text = "Le stock du cr??dit " +
                element.nom +
                " est en dessous du seuil d'approvisionnement. Il ne reste que " +
                element.montant_disponible.toString() +
                " F en stock. Le r??chargement de ce cr??dit est donc n??cessaire";
          //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }

          await FirebaseFirestore.instance
              .collection("reseaux_communication")
              .doc(element.uid)
              .update({'approvisionne': true});
        }
      });

      _list_bierres_grand_modele.forEach((element) async {
        if (element.quantite_physique < element.seuil_approvisionnement &&
            !element.approvisionne) {
          await WhatsappShare.share(
            text: "Bonsoir Monsieur! Le r??chargement du bi??rre grand mod??le " +
                element.nom +
                " est r??quis. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock de l'entreprise ",
            phone: '22997392026',
          );

          String username = 'deogracias228';
          String password = 'DEOgracias228';

          final smtpServer = gmail(username, password);
          // Use the SmtpServer class to configure an SMTP server:
          // final smtpServer = SmtpServer('smtp.domain.com');
          // See the named arguments of SmtpServer for further configuration
          // options.

          // Create our message.
          final message = Message()
            ..from = Address(username, 'D??o Gracias Entreprise')
            ..recipients.add('kpangbanoumarcellin@gmail.com')
            ..ccRecipients
            //.addAll(['destCc1@example.com', 'destCc2@example.com'])
            //..bccRecipients.add(Address('bccAddress@example.com'))
            ..subject = 'D??mande de r??chargement de stock'
            ..text = "Le stock du grand mod??le " +
                element.nom +
                " est en dessous du seuil d'approvisionnement. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock. Le r??chargement de cette bi??rre est donc n??cessaire";
          //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }

          await FirebaseFirestore.instance
              .collection("bierres")
              .doc(element.uid)
              .update({'approvisionne': true});
        }
      });

      _list_bierres_petit_modele.forEach((element) async {
        if (element.quantite_physique < element.seuil_approvisionnement &&
            !element.approvisionne) {
          await WhatsappShare.share(
            text: "Bonsoir Monsieur! Le r??chargement du bi??rre p??tit mod??le " +
                element.nom +
                " est r??quis. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock de l'entreprise ",
            phone: '22997392026',
          );

          String username = 'deogracias228';
          String password = 'DEOgracias228';

          final smtpServer = gmail(username, password);
          // Use the SmtpServer class to configure an SMTP server:
          // final smtpServer = SmtpServer('smtp.domain.com');
          // See the named arguments of SmtpServer for further configuration
          // options.

          // Create our message.
          final message = Message()
            ..from = Address(username, 'D??o Gracias Entreprise')
            ..recipients.add('kpangbanoumarcellin@gmail.com')
            ..ccRecipients
            //.addAll(['destCc1@example.com', 'destCc2@example.com'])
            //..bccRecipients.add(Address('bccAddress@example.com'))
            ..subject = 'D??mande de r??chargement de stock'
            ..text = "Le stock du p??tit mod??le " +
                element.nom +
                " est en dessous du seuil d'approvisionnement. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock. Le r??chargement de cette bi??rre est donc n??cessaire";
          //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }

          await FirebaseFirestore.instance
              .collection("bierres")
              .doc(element.uid)
              .update({'approvisionne': true});
        }
      });

      _list_tee_shirt.forEach((element) async {
        if (element.quantite_physique < element.seuil_approvisionnement &&
            !element.approvisionne) {
          await WhatsappShare.share(
            text: "Bonsoir Monsieur! Le r??chargement de tee shirt " +
                element.tee_shirt_nom +
                " de " +
                element.qualite +
                " est r??quis. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock de l'entreprise ",
            phone: '22997392026',
          );

          String username = 'deogracias228';
          String password = 'DEOgracias228';

          final smtpServer = gmail(username, password);
          // Use the SmtpServer class to configure an SMTP server:
          // final smtpServer = SmtpServer('smtp.domain.com');
          // See the named arguments of SmtpServer for further configuration
          // options.

          // Create our message.
          final message = Message()
            ..from = Address(username, 'D??o Gracias Entreprise')
            ..recipients.add('kpangbanoumarcellin@gmail.com')
            ..ccRecipients
            //.addAll(['destCc1@example.com', 'destCc2@example.com'])
            //..bccRecipients.add(Address('bccAddress@example.com'))
            ..subject = 'D??mande de r??chargement de stock'
            ..text = "Le stock du  " +
                element.tee_shirt_nom +
                " de " +
                element.qualite +
                " est en dessous du seuil d'approvisionnement. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock. Le r??chargement de ce tee shirt est donc n??cessaire";
          //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }

          await FirebaseFirestore.instance
              .collection("tee_shirts")
              .doc(element.uid)
              .update({'approvisionne': true});
        }
      });

      _list_produits_centre.forEach((element) async {
        if (element.quantite_physique < element.seuil_approvisionnement &&
            !element.approvisionne) {
          await WhatsappShare.share(
            text: "Bonsoir Monsieur! Le r??chargement de  " +
                element.nom +
                " est r??quis. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock de l'entreprise ",
            phone: '22997392026',
          );

          String username = 'deogracias228';
          String password = 'DEOgracias228';

          final smtpServer = gmail(username, password);
          // Use the SmtpServer class to configure an SMTP server:
          // final smtpServer = SmtpServer('smtp.domain.com');
          // See the named arguments of SmtpServer for further configuration
          // options.

          // Create our message.
          final message = Message()
            ..from = Address(username, 'D??o Gracias Entreprise')
            ..recipients.add('kpangbanoumarcellin@gmail.com')
            ..ccRecipients
            //.addAll(['destCc1@example.com', 'destCc2@example.com'])
            //..bccRecipients.add(Address('bccAddress@example.com'))
            ..subject = 'D??mande de r??chargement de stock'
            ..text = "Le stock du  " +
                element.nom +
                " est en dessous du seuil d'approvisionnement. Il ne reste que " +
                element.quantite_physique.toString() +
                "  en stock. Le r??chargement de ce produit est donc n??cessaire";
          //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }

          await FirebaseFirestore.instance
              .collection("tee_shirts")
              .doc(element.uid)
              .update({'approvisionne': true});
        }
      });
    });

    // rapport rubrique journalier

    _cron.schedule(Schedule.parse('0 20 * * *'), () async {
      _benefice_total_credit = 0;
      montant_total_vente_credit = 0;
      montant_vendu_credit = 0;
      total_benefice_tee_shirt = 0;
      total_quantite_tee_shirt = 0;
      montant_vente_tee_shirt = 0;

      total_benefice_produits = 0;
      total_quantite_produits = 0;
      montant_vente_produits = 0;

      total_benefice_grand_modele = 0;
      total_quantite_grand_modele = 0;
      montant_vente_grand_modele = 0;

      total_benefice_tee_petit_modele = 0;
      total_quantite_petit_modele = 0;
      montant_vente_petit_modele = 0;
      totaux_vente = 0;
      totaux_benefice = 0;
      print(" ok ");

      _pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                height: 10,
              ),
              pw.Text("Rapprt journalier de vente ".toUpperCase(),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 22,
                      color: PdfColors.black)),
              _list_credits.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de cr??dits".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Cr??dit",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant intial",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant vendu",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant restant",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            credit _credit = _list_credits[index];
                            // _credit_nom = _vente_credit.nom;
                            _list_vente_credits.forEach((element) {
                              if (element.nom == _credit_nom &&
                                  element.date_vente_day == _current_day) {
                                _benefice_total_credit += element.benefice;
                                montant_vendu_credit += element.montant;
                                montant_total_vente_credit += element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_credit;
                            totaux_benefice += _benefice_total_credit;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_credit.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _credit.montant_initial.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      montant_vendu_credit.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _credit.montant_disponible.toString() +
                                          " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vendu_credit = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_credits.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Total vente de cr??dit ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_credit.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute du cr??dit "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    _benefice_total_credit.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_tee_shirt.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de tee shirts".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Tee shirt".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            serigraphie _tee_shirt = _list_tee_shirt[index];

                            _list_vente_tee_shirts.forEach((element) {
                              if (element.nom_tee_shirts ==
                                      _tee_shirt.tee_shirt_nom &&
                                  element.date_vente_day == _current_day) {
                                montant_vente_tee_shirt += element.montant;
                                total_benefice_tee_shirt += element.benefice;
                                total_quantite_tee_shirt += element.quantite;
                                montant_total_vente_tee_shirt +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_tee_shirt;
                            totaux_benefice += total_benefice_tee_shirt;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_tee_shirt.tee_shirt_nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.quantite_initial.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_tee_shirt.toString() +
                                          " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.quantite_physique.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.prix_unitaire_vente.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_tee_shirt.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_tee_shirt = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_tee_shirt.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de tee shirt ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_tee_shirt.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de tee shirt "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_tee_shirt.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_produits_centre.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de produits".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Produit".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            products _produit = _list_produits_centre[index];

                            _list_vente_produits.forEach((element) {
                              if (element.nom_produit == _produit.nom &&
                                  element.vente_day == _current_day) {
                                montant_vente_produits += element.montant;
                                total_benefice_produits += element.benefice;
                                total_quantite_produits += element.quantite;
                                montant_total_vente_produits += element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_produits;
                            totaux_benefice += total_benefice_produits;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_produit.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.quantite_initial.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_produits.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.quantite_physique.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_produits.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_tee_shirt = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_produits_centre.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de produits ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_produits.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de produits "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_produits.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_bierres_petit_modele.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text(
                              "Vente de p??tits mod??les".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Nom du bi??rre".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            donneesBieerePetitModele _petits_modele =
                                _list_bierres_petit_modele[index];

                            _list_vente_petit_modele.forEach((element) {
                              if (element.nom_bierre == _petits_modele.nom &&
                                  element.date_vente_day == _current_day) {
                                montant_vente_petit_modele += element.montant;
                                total_benefice_tee_petit_modele +=
                                    element.benefice;
                                total_quantite_petit_modele += element.quantite;
                                montant_total_vente_petit_modele +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_petit_modele;
                            totaux_benefice += total_benefice_tee_petit_modele;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_petits_modele.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_initial
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_petit_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_physique
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_petit_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_petit_modele = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_bierres_petit_modele.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de bi??rres p??tit mod??le "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_petit_modele
                                            .toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de p??tits mod??le "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_tee_petit_modele.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_bierres_grand_modele.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text(
                              "Vente de grands mod??les".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Nom du bi??rre".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            donnesBierresGrandModel _petits_modele =
                                _list_bierres_grand_modele[index];

                            _list_vente_grand_modele.forEach((element) {
                              if (element.nom_bierre == _petits_modele.nom &&
                                  element.date_vente_day == _current_day) {
                                montant_vente_grand_modele += element.montant;
                                total_benefice_grand_modele += element.benefice;
                                total_quantite_grand_modele += element.quantite;
                                montant_total_vente_grand_modele +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_grand_modele;
                            totaux_benefice += total_benefice_grand_modele;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_petits_modele.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_initial
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_grand_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_physique
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_grand_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_grand_modele = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_bierres_grand_modele.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de grand mod??les "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_grand_modele
                                            .toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de grand mod??les "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_grand_modele.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              pw.Container(
                  color: PdfColors.green,
                  width: double.infinity,
                  height: 40,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisSize: pw.MainAxisSize.max,
                      children: [
                        pw.Text(
                            "Montant total de vente de la journ????"
                                .toUpperCase()
                                .toUpperCase(),
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(totaux_vente.toString() + " F",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold))
                      ])),
              pw.Container(
                  color: PdfColors.indigo,
                  width: double.infinity,
                  height: 40,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisSize: pw.MainAxisSize.max,
                      children: [
                        pw.Text(
                            "Total de b??n??fice brute r??lis?? pour cette journ??e"
                                .toUpperCase()
                                .toUpperCase(),
                            style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(totaux_benefice.toString() + " F",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold))
                      ]))
            ],
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

      String username = 'deogracias228';
      String password = 'DEOgracias228';

      final smtpServer = gmail(username, password);

      final equivalentMessage = Message()
        ..from = Address(username, 'Entreprise D??o Gracias')
        ..recipients.add(Address('kpangbanoumarcellin@gmail.com'))
        ..ccRecipients
        // .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
        // ..bccRecipients.add('bccAddress@example.com')
        ..subject = 'Rapport journalier de vente'
        ..text =
            'Bonsoir Monsieur le PDG de  D??o Gracias. Voici le rapport journalier de vente au niveau du centre informatique et du bar restaurant.'
        //..html =
        //  '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
        ..attachments = [
          FileAttachment(File('rapports/rapport_journalier.pdf'))
            ..location = Location.inline
            ..cid = 'rapport_journalier.pdf'
        ];

      try {
        final sendReport2 = await send(equivalentMessage, smtpServer);
        print('Message sent: ' + sendReport2.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    });

    // rapport hebdomendaire await _file1.writeAsBytes( await _pdf.save())
    _cron.schedule(Schedule.parse('10 20 * * 0'), () async {
      print(" ok ");
      _benefice_total_credit = 0;
      montant_total_vente_credit = 0;
      montant_vendu_credit = 0;
      total_benefice_tee_shirt = 0;
      total_quantite_tee_shirt = 0;
      montant_vente_tee_shirt = 0;

      total_benefice_produits = 0;
      total_quantite_produits = 0;
      montant_vente_produits = 0;

      total_benefice_grand_modele = 0;
      total_quantite_grand_modele = 0;
      montant_vente_grand_modele = 0;

      total_benefice_tee_petit_modele = 0;
      total_quantite_petit_modele = 0;
      montant_vente_petit_modele = 0;
      totaux_vente = 0;
      totaux_benefice = 0;
      print(" ok ");

      _pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                height: 10,
              ),
              pw.Text("Rapprt journalier de vente ".toUpperCase(),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 22,
                      color: PdfColors.black)),
              _list_credits.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de cr??dits".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Cr??dit",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant intial",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant vendu",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant restant",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            credit _credit = _list_credits[index];
                            // _credit_nom = _vente_credit.nom;
                            _list_vente_credits.forEach((element) {
                              if (element.nom == _credit_nom &&
                                  element.date_vente_day == _current_day) {
                                _benefice_total_credit += element.benefice;
                                montant_vendu_credit += element.montant;
                                montant_total_vente_credit += element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_credit;
                            totaux_benefice += _benefice_total_credit;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_credit.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _credit.montant_initial.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      montant_vendu_credit.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _credit.montant_disponible.toString() +
                                          " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vendu_credit = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_credits.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Total vente de cr??dit ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_credit.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute du cr??dit "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    _benefice_total_credit.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_tee_shirt.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de tee shirts".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Tee shirt".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            serigraphie _tee_shirt = _list_tee_shirt[index];

                            _list_vente_tee_shirts.forEach((element) {
                              if (element.nom_tee_shirts ==
                                      _tee_shirt.tee_shirt_nom &&
                                  element.date_vente_day == _current_day) {
                                montant_vente_tee_shirt += element.montant;
                                total_benefice_tee_shirt += element.benefice;
                                total_quantite_tee_shirt += element.quantite;
                                montant_total_vente_tee_shirt +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_tee_shirt;
                            totaux_benefice += total_benefice_tee_shirt;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_tee_shirt.tee_shirt_nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.quantite_initial.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(total_quantite_tee_shirt.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.quantite_physique.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.prix_unitaire_vente.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_tee_shirt.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_tee_shirt = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_tee_shirt.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de tee shirt ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_tee_shirt.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de tee shirt "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_tee_shirt.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_produits_centre.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de produits".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Produit".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            products _produit = _list_produits_centre[index];

                            _list_vente_produits.forEach((element) {
                              if (element.nom_produit == _produit.nom &&
                                  element.vente_day == _current_day) {
                                montant_vente_produits += element.montant;
                                total_benefice_produits += element.benefice;
                                total_quantite_produits += element.quantite;
                                montant_total_vente_produits += element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_produits;
                            totaux_benefice += total_benefice_produits;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_produit.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.quantite_initial.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_produits.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.quantite_physique.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_produits.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_tee_shirt = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_produits_centre.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de produits ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_produits.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de produits "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_produits.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_bierres_petit_modele.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text(
                              "Vente de p??tits mod??les".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Nom du bi??rre".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            donneesBieerePetitModele _petits_modele =
                                _list_bierres_petit_modele[index];

                            _list_vente_petit_modele.forEach((element) {
                              if (element.nom_bierre == _petits_modele.nom &&
                                  element.date_vente_day == _current_day) {
                                montant_vente_petit_modele += element.montant;
                                total_benefice_tee_petit_modele +=
                                    element.benefice;
                                total_quantite_petit_modele += element.quantite;
                                montant_total_vente_petit_modele +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_petit_modele;
                            totaux_benefice += total_benefice_tee_petit_modele;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_petits_modele.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_initial
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_petit_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_physique
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_petit_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_petit_modele = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_bierres_petit_modele.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de bi??rres p??tit mod??le "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_petit_modele
                                            .toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de p??tits mod??le "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_tee_petit_modele.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_bierres_grand_modele.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text(
                              "Vente de grands mod??les".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Nom du bi??rre".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            donnesBierresGrandModel _petits_modele =
                                _list_bierres_grand_modele[index];

                            _list_vente_grand_modele.forEach((element) {
                              if (element.nom_bierre == _petits_modele.nom &&
                                  element.date_vente_day == _current_day) {
                                montant_vente_grand_modele += element.montant;
                                total_benefice_grand_modele += element.benefice;
                                total_quantite_grand_modele += element.quantite;
                                montant_total_vente_grand_modele +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_grand_modele;
                            totaux_benefice += total_benefice_grand_modele;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_petits_modele.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_initial
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_grand_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_physique
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_grand_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_grand_modele = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_bierres_grand_modele.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de grand mod??les "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_grand_modele
                                            .toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de grand mod??les "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_grand_modele.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              pw.Container(
                  color: PdfColors.green,
                  width: double.infinity,
                  height: 40,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisSize: pw.MainAxisSize.max,
                      children: [
                        pw.Text(
                            "Montant total de vente de la journ????"
                                .toUpperCase()
                                .toUpperCase(),
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(totaux_vente.toString() + " F",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold))
                      ])),
              pw.Container(
                  color: PdfColors.indigo,
                  width: double.infinity,
                  height: 40,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisSize: pw.MainAxisSize.max,
                      children: [
                        pw.Text(
                            "Total de b??n??fice brute r??lis?? pour cette journ??e"
                                .toUpperCase()
                                .toUpperCase(),
                            style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(totaux_benefice.toString() + " F",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold))
                      ]))
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

      String username = 'deogracias228';
      String password = 'DEOgracias228';

      final smtpServer = gmail(username, password);

      final equivalentMessage = Message()
        ..from = Address(username, 'Entreprise D??o Gracias')
        ..recipients.add(Address('kpangbanoumarcellin@gmail.com'))
        ..ccRecipients
        // .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
        // ..bccRecipients.add('bccAddress@example.com')
        ..subject = 'Rapport hebdomendaire de vente'
        ..text =
            'Bonsoir Monsieur le PDG de  D??o Gracias. Voici le rapport hebdomendaire de vente au niveau du centre informatique et du bar restaurant.'
        //..html =
        //  '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
        ..attachments = [
          FileAttachment(File('rapports/rapport_journalier.pdf'))
            ..location = Location.inline
            ..cid = 'rapport_journalier.pdf'
        ];

      try {
        final sendReport2 = await send(equivalentMessage, smtpServer);
        print('Message sent: ' + sendReport2.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    });

    // rapport mensuel

    _cron.schedule(Schedule.parse('0 20 1 * *'), () async {
      print(" ok ");

      _benefice_total_credit = 0;
      montant_total_vente_credit = 0;
      montant_vendu_credit = 0;
      total_benefice_tee_shirt = 0;
      total_quantite_tee_shirt = 0;
      montant_vente_tee_shirt = 0;

      total_benefice_produits = 0;
      total_quantite_produits = 0;
      montant_vente_produits = 0;

      total_benefice_grand_modele = 0;
      total_quantite_grand_modele = 0;
      montant_vente_grand_modele = 0;

      total_benefice_tee_petit_modele = 0;
      total_quantite_petit_modele = 0;
      montant_vente_petit_modele = 0;
      totaux_vente = 0;
      totaux_benefice = 0;
      print(" ok ");

      _pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                height: 10,
              ),
              pw.Text("Rapprt mensuel de vente ".toUpperCase(),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 22,
                      color: PdfColors.black)),
              _list_credits.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de cr??dits".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Cr??dit",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant intial",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant vendu",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Montant restant",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            credit _credit = _list_credits[index];
                            // _credit_nom = _vente_credit.nom;
                            _list_vente_credits.forEach((element) {
                              if (element.nom == _credit_nom &&
                                  element.date_vente_month == _current_month) {
                                _benefice_total_credit += element.benefice;
                                montant_vendu_credit += element.montant;
                                montant_total_vente_credit += element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_credit;
                            totaux_benefice += _benefice_total_credit;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_credit.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _credit.montant_initial.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      montant_vendu_credit.toString() + " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _credit.montant_disponible.toString() +
                                          " F",
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vendu_credit = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_credits.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Total vente de cr??dit ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_credit.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute du cr??dit "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    _benefice_total_credit.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_tee_shirt.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de tee shirts".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Tee shirt".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            serigraphie _tee_shirt = _list_tee_shirt[index];

                            _list_vente_tee_shirts.forEach((element) {
                              if (element.nom_tee_shirts ==
                                      _tee_shirt.tee_shirt_nom &&
                                  element.date_vente_month == _current_month) {
                                montant_vente_tee_shirt += element.montant;
                                total_benefice_tee_shirt += element.benefice;
                                total_quantite_tee_shirt += element.quantite;
                                montant_total_vente_tee_shirt +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_tee_shirt;
                            totaux_benefice += total_benefice_tee_shirt;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_tee_shirt.tee_shirt_nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.quantite_initial.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(total_quantite_tee_shirt.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.quantite_physique.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _tee_shirt.prix_unitaire_vente.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_tee_shirt.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_tee_shirt = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_tee_shirt.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de tee shirt ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_tee_shirt.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de tee shirt "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_tee_shirt.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_produits_centre.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text("Vente de produits".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Produit".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            products _produit = _list_produits_centre[index];

                            _list_vente_produits.forEach((element) {
                              if (element.nom_produit == _produit.nom &&
                                  element.vente_month == _current_month) {
                                montant_vente_produits += element.montant;
                                total_benefice_produits += element.benefice;
                                total_quantite_produits += element.quantite;
                                montant_total_vente_produits += element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_produits;
                            totaux_benefice += total_benefice_produits;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_produit.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.quantite_initial.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(total_quantite_produits.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.quantite_physique.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(_produit.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_produits.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_tee_shirt = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_produits_centre.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de produits ".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_produits.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de produits "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_produits.toString() + " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_bierres_petit_modele.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text(
                              "Vente de p??tits mod??les".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Nom du bi??rre".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            donneesBieerePetitModele _petits_modele =
                                _list_bierres_petit_modele[index];

                            _list_vente_petit_modele.forEach((element) {
                              if (element.nom_bierre == _petits_modele.nom &&
                                  element.date_vente_month == _current_month) {
                                montant_vente_petit_modele += element.montant;
                                total_benefice_tee_petit_modele +=
                                    element.benefice;
                                total_quantite_petit_modele += element.quantite;
                                montant_total_vente_petit_modele +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_petit_modele;
                            totaux_benefice += total_benefice_tee_petit_modele;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_petits_modele.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_initial
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_petit_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_physique
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_petit_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_petit_modele = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_bierres_petit_modele.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de bi??rres p??tit mod??le "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_petit_modele
                                            .toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de p??tits mod??les "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_tee_petit_modele.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              _list_bierres_grand_modele.isNotEmpty
                  ? pw.Column(children: [
                      pw.Container(
                          color: PdfColors.redAccent,
                          width: double.infinity,
                          height: 40,
                          child: pw.Text(
                              "Vente de grands mod??les".toUpperCase(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Container(
                          width: double.infinity,
                          height: 40,
                          color: PdfColors.indigo,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text("Nom du bi??rre".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? initiale".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? vendue".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Quantit?? restante".toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Prix unitaire de vente"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    "Montant total vendu"
                                        .toUpperCase()
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ])),
                      pw.ListView.separated(
                          itemBuilder: ((context, index) {
                            donnesBierresGrandModel _petits_modele =
                                _list_bierres_grand_modele[index];

                            _list_vente_grand_modele.forEach((element) {
                              if (element.nom_bierre == _petits_modele.nom &&
                                  element.date_vente_month == _current_month) {
                                montant_vente_grand_modele += element.montant;
                                total_benefice_grand_modele += element.benefice;
                                total_quantite_grand_modele += element.quantite;
                                montant_total_vente_grand_modele +=
                                    element.montant;
                              }
                            });

                            totaux_vente += montant_total_vente_grand_modele;
                            totaux_benefice += total_benefice_grand_modele;

                            return pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisSize: pw.MainAxisSize.max,
                                children: [
                                  pw.Text(_petits_modele.nom,
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_initial
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      total_quantite_grand_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.quantite_physique
                                          .toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(
                                      _petits_modele.prix_unitaire.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text(montant_vente_grand_modele.toString(),
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 22,
                                          fontWeight: pw.FontWeight.bold)),
                                ]);
                            montant_vente_grand_modele = 0;
                          }),
                          separatorBuilder: ((context, index) => pw.Divider()),
                          itemCount: _list_bierres_grand_modele.length),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          color: PdfColors.indigo,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total vente de grand mod??les "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    montant_total_vente_grand_modele
                                            .toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ])),
                      pw.SizedBox(height: 0),
                      pw.Container(
                          color: PdfColors.green,
                          width: double.infinity,
                          height: 40,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisSize: pw.MainAxisSize.max,
                              children: [
                                pw.Text(
                                    "Total b??n??fice brute de grand mod??les "
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    total_benefice_grand_modele.toString() +
                                        " F",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 22,
                                        fontWeight: pw.FontWeight.bold))
                              ]))
                    ])
                  : pw.Container(),
              pw.SizedBox(height: 10),
              pw.Container(
                  color: PdfColors.green,
                  width: double.infinity,
                  height: 40,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisSize: pw.MainAxisSize.max,
                      children: [
                        pw.Text(
                            "Montant total de vente de la journ????"
                                .toUpperCase()
                                .toUpperCase(),
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(totaux_vente.toString() + " F",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold))
                      ])),
              pw.Container(
                  color: PdfColors.indigo,
                  width: double.infinity,
                  height: 40,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisSize: pw.MainAxisSize.max,
                      children: [
                        pw.Text(
                            "Total de b??n??fice brute r??lis?? pour cette journ??e"
                                .toUpperCase()
                                .toUpperCase(),
                            style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(totaux_benefice.toString() + " F",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold))
                      ]))
            ],
          );
        },
      ));

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

      String username = 'deogracias228';
      String password = 'DEOgracias228';

      final smtpServer = gmail(username, password);

      final equivalentMessage = Message()
        ..from = Address(username, 'Entreprise D??o Gracias')
        ..recipients.add(Address('kpangbanoumarcellin@gmail.com'))
        ..ccRecipients
        // .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
        // ..bccRecipients.add('bccAddress@example.com')
        ..subject = 'Rapport mensuel de vente'
        ..text =
            'Bonsoir Monsieur le PDG de  D??o Gracias. Voici le rapport mensuel de vente au niveau du centre informatique et du bar restaurant.'
        //..html =
        //  '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
        ..attachments = [
          FileAttachment(File('rapports/rapport_mensuel.pdf'))
            ..location = Location.inline
            ..cid = 'rapport_mensuel.pdf'
        ];

      try {
        final sendReport2 = await send(equivalentMessage, smtpServer);
        print('Message sent: ' + sendReport2.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    });

    if (firebase == null) {
      return Accueil();
    }
    if (_donnnes.is_active != true) return Welcome();
    if (_donnnes.admin == true) return HomePage();
    if (_donnnes.role == "Servant") {
      if (_donnnes.domaine == "Bar restaurant") {
        return AccueilServantBar();
      } else if (_donnnes.domaine == "Centre informatique") {
        return AccueilServantCentre();
      } else
        return Welcome();
    }

    return Welcome();
  }
}
