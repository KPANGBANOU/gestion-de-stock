// ignore_for_file: camel_case_types, dead_code, prefer_final_fields, prefer_typing_uninitialized_variables, empty_constructor_bodies, non_constant_identifier_names, unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';

import 'package:projet/modele/budgetBar.dart';
import 'package:projet/modele/budget_centre.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/credits_servants.dart';
import 'package:projet/modele/credits_vente.dart';

import 'package:projet/modele/depense.dart';
import 'package:projet/modele/depense_centre.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/modele/probleme.dart';
import 'package:projet/modele/probleme_centre.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';
import 'package:projet/modele/vente_tee_shirts.dart';

import 'package:projet/services/user.dart';

class serviceBD {
  final FirebaseFirestore _Ref = FirebaseFirestore.instance;
// user data
  Stream<donnesUtilisateur> donnes(String user_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .snapshots()
        .map((snap) => donnesUtilisateur.fromFiresotre(snap));
  }

  Stream<List<CreditsServants>> credits_servant(String servant_uid) {
    return _Ref.collection("credits_centre")
        .where("servant_uid", isEqualTo: servant_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CreditsServants.fromFirestore(e)).toList());
  }

  Stream<CreditsServants> credit_servant(String credit_uid) {
    return _Ref.collection("credits_centre")
        .doc(credit_uid)
        .snapshots()
        .map((event) => CreditsServants.fromFirestore(event));
  }

  Stream<List<CreditsServants>> get list_credits_vente_centre {
    return _Ref.collection("credits_centre").snapshots().map((event) =>
        event.docs.map((e) => CreditsServants.fromFirestore(e)).toList());
  }

  Stream<List<CreditsVente>> credits_servant_bar(String servant_uid) {
    return _Ref.collection("credits")
        .where("servant_uid", isEqualTo: servant_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CreditsVente.fromFirestore(e)).toList());
  }

  Stream<CreditsVente> credit_servant_bar(String credit_uid) {
    return _Ref.collection("credits")
        .doc(credit_uid)
        .snapshots()
        .map((event) => CreditsVente.fromFirestore(event));
  }

  Stream<List<CreditsVente>> get list_credits_vente_bar {
    return _Ref.collection("credits").snapshots().map((event) =>
        event.docs.map((e) => CreditsVente.fromFirestore(e)).toList());
  }

  Stream<donnesUtilisateur> get currentuserdata {
    return _Ref.collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((event) => donnesUtilisateur.fromFiresotre(event));
  }

  Future<String> addUser(String uid, String nom, String prenom, String sexe,
      String telephone, String date_naissance, String email) async {
    try {
      await _Ref.collection("users").doc(uid).set({
        "nom": nom,
        "prenom": prenom,
        "sexe": sexe,
        "date_naissance": date_naissance,
        "telephone": telephone,
        "email": email,
        "timestamp": DateTime.now(),
        "admin": false,
        "is_active": true,
      }).then((value) {
        return "Compte créeé avec succès";
      });
    } catch (e) {
      return "Echec";
    }
    return "Echec";
  }

  Stream<List<serigraphie>> get list_tee_shirts {
    return _Ref.collection("tee_shirts").orderBy("created_at").snapshots().map(
        (event) =>
            event.docs.map((e) => serigraphie.fromfirestore(e)).toList());
  }

  Stream<serigraphie> tee_shirt(String tee_shirt_uid) {
    return _Ref.collection("tee_shirts")
        .doc(tee_shirt_uid)
        .snapshots()
        .map((event) => serigraphie.fromfirestore(event));
  }

  Stream<List<venteteeshirts>> list_vente_tee_shirt(String user_uid) {
    return _Ref.collection("vente_tee_shirts")
        .where("user_uid", isEqualTo: user_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => venteteeshirts.fromfirestore(e)).toList());
  }

  Stream<List<venteteeshirts>> get tous_les_vente_tee_shirts {
    return _Ref.collection("vente_tee_shirts").snapshots().map((event) =>
        event.docs.map((e) => venteteeshirts.fromfirestore(e)).toList());
  }

  Stream<List<centreVente>> get tous_les_ventes_produits {
    return _Ref.collection("centre_vente_produits").snapshots().map((event) =>
        event.docs.map((e) => centreVente.fromfirestore(e)).toList());
  }

  Stream<venteteeshirts> vente_tee_shirt(String vente_tee_shirt_uid) {
    return _Ref.collection('vente_tee_shirts')
        .doc(vente_tee_shirt_uid)
        .snapshots()
        .map((event) => venteteeshirts.fromfirestore(event));
  }

  // liste de produits

  Stream<List<products>> get list_produits_centre {
    return _Ref.collection("produits_centre").snapshots().map(
        (event) => event.docs.map((e) => products.fromFirestore(e)).toList());
  }

  Stream<List<venteGrandModele>> get tous_les_ventes_grand_modeles {
    return _Ref.collection("ventes_grand_modele").snapshots().map((event) =>
        event.docs.map((e) => venteGrandModele.fromFirestore(e)).toList());
  }

  Stream<List<ventePetitModele>> get tous_les_ventes_petit_modeles {
    return _Ref.collection("ventes_petit_modele").snapshots().map((event) =>
        event.docs.map((e) => ventePetitModele.fromFirestore(e)).toList());
  }

  Stream<List<venteCredit>> get tous_les_ventes_credits {
    return _Ref.collection("vente_credits").snapshots().map((event) =>
        event.docs.map((e) => venteCredit.fromFirestore(e)).toList());
  }

  // produit du centre

  Stream<products> produit_centre(String produit_uid) {
    return _Ref.collection("produits_centre")
        .doc(produit_uid)
        .snapshots()
        .map((event) => products.fromFirestore(event));
  }

  // list de vente de credits

  Stream<List<centreVente>> centre_list_vente_produits(String employe_uid) {
    return _Ref.collection("centre_vente_produits")
        .where("user_uid", isEqualTo: employe_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => centreVente.fromfirestore(e)).toList());
  }

  Stream<List<ventePetitModele>> list_vente_petit_modele(String employe_uid) {
    return _Ref.collection("ventes_petit_modele")
        .where("user_uid", isEqualTo: employe_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ventePetitModele.fromFirestore(e)).toList());
  }

  Stream<ventePetitModele> vente_petit_modele(String vente_uid) {
    return _Ref.collection("ventes_petit_modele")
        .doc(vente_uid)
        .snapshots()
        .map((event) => ventePetitModele.fromFirestore(event));
  }

  Stream<List<venteGrandModele>> list_vente_grand_modele(String employe_uid) {
    return _Ref.collection("ventes_grand_modele")
        .where("user_uid", isEqualTo: employe_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => venteGrandModele.fromFirestore(e)).toList());
  }

  Stream<venteGrandModele> vente_grand_modele(String vente_uid) {
    return _Ref.collection("ventes_grand_modele")
        .doc(vente_uid)
        .snapshots()
        .map((event) => venteGrandModele.fromFirestore(event));
  }

  // ventre centre

  Stream<centreVente> centre_vente_produit(String vente_uid) {
    return _Ref.collection("centre_vente_produits")
        .doc(vente_uid)
        .snapshots()
        .map((event) => centreVente.fromfirestore(event));
  }

  Stream<List<venteCredit>> list_vente_credits(String employe_uid) {
    return _Ref.collection("vente_credits")
        .where("user_uid", isEqualTo: employe_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => venteCredit.fromFirestore(e)).toList());
  }

  Stream<venteCredit> vente_credit(String vente_credit_uid) {
    return _Ref.collection("vente_credits")
        .doc(vente_credit_uid)
        .snapshots()
        .map((event) => venteCredit.fromFirestore(event));
  }

  Stream<List<donnesServants>> list_servants(String domaine_name) {
    return _Ref.collection("users")
        .where('domaine', isEqualTo: domaine_name)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => donnesServants.fromFiresotre(e)).toList());
  }

  Stream<donnesServants> servant_data(String servant_uid) {
    return _Ref.collection("users")
        .doc(servant_uid)
        .snapshots()
        .map((event) => donnesServants.fromFiresotre(event));
  }

  // list de reseaux credits

  Stream<List<credit>> get list_reseaux_credits {
    return _Ref.collection("reseaux_communication").snapshots().map(
        (event) => event.docs.map((e) => credit.fromfirestore(e)).toList());
  }

  // credit stream
  Stream<credit> reseau_credit(String credit_uid) {
    return _Ref.collection("reseaux_communication")
        .doc(credit_uid)
        .snapshots()
        .map((event) => credit.fromfirestore(event));
  }

  // accoder droits donnesUtilisateurs

  Stream<List<donnesUtilisateur>> infoEmploye(String email) {
    return _Ref.collection("users")
        .where('email', isEqualTo: email)
        .limit(1)
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => donnesUtilisateur.fromFiresotre(e)).toList());
  }

  // list of users
  Stream<List<donnesUtilisateur>> get listDonnesUtilisateur {
    return _Ref.collection("users").snapshots().map((documents) => documents
        .docs
        .map((snap) => donnesUtilisateur.fromFiresotre(snap))
        .toList());
  }

// bierre petit modele data
  Stream<donneesBieerePetitModele> bierreData(String bierreId) {
    return _Ref.collection("bierres")
        .doc(bierreId)
        .snapshots()
        .map((snap) => donneesBieerePetitModele.fromFirestore(snap));
  }

// list of small modal of biar
  Stream<List<donneesBieerePetitModele>> get listDonnesBierresPetitModele {
    return _Ref.collection("bierres")
        .where("type", isEqualTo: "Pétit modèle")
        //.orderBy("created_at")
        .snapshots()
        .map((documents) => documents.docs
            .map((snap) => donneesBieerePetitModele.fromFirestore(snap))
            .toList());
  }

  // list des depenses de l'employé connecté maintenant
  Stream<List<donnesDepense>> list_depenses_bar(String user_uid) {
    return _Ref.collection("depenses")
        .where("user_uid", isEqualTo: user_uid)
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => donnesDepense.fromFirestore(e)).toList());
  }

  Stream<donnesDepense> depenses_bar(String depense_uid) {
    return _Ref.collection("depenses")
        .doc(depense_uid)
        .snapshots()
        .map((snap) => donnesDepense.fromFirestore(snap));
  }

  Stream<List<donnesDepense>> get tous_les_depenses_bar {
    return _Ref.collection("depenses").snapshots().map((snap) =>
        snap.docs.map((e) => donnesDepense.fromFirestore(e)).toList());
  }

  // list of depense par employé

  Stream<List<DepenseCentre>> list_depense_centre(String user_id) {
    return _Ref.collection("depenses_centre")
        .where("user_uid", isEqualTo: user_id)
        .snapshots()
        .map((documents) => documents.docs
            .map((snap) => DepenseCentre.fromFirestore(snap))
            .toList());
  }

  Stream<DepenseCentre> depense_centre(String depense_id) {
    return _Ref.collection("depenses_centre")
        .doc(depense_id)
        .snapshots()
        .map((documents) => DepenseCentre.fromFirestore(documents));
  }

  Stream<List<DepenseCentre>> get tous_les_depense_centre {
    return _Ref.collection("depenses_centre").snapshots().map((documents) =>
        documents.docs
            .map((snap) => DepenseCentre.fromFirestore(snap))
            .toList());
  }

  // biar big modal data

  Stream<donnesBierresGrandModel> bierreGrandModele(String uid) {
    return _Ref.collection("bierres")
        .doc(uid)
        .snapshots()
        .map((snap) => donnesBierresGrandModel.fromFirestore(snap));
  }

  // list of big modal biar

  Stream<List<donnesBierresGrandModel>> get lisBiarGrandModel {
    return _Ref.collection("bierres")
        .where("type", isEqualTo: "Grand modèle")
        // .orderBy("created_at")
        .snapshots()
        .map((documents) => documents.docs
            .map((snap) => donnesBierresGrandModel.fromFirestore(snap))
            .toList());
  }

  // list des servants du bar

  Stream<List<donnesServants>> get servantBar {
    return _Ref.collection("users")
        //.where('role', isEqualTo: "Servant")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => donnesServants.fromFiresotre(e)).toList());
  }

  // budget bar data

  Stream<BudgetBar> get budgetBardata {
    return _Ref.collection('budget')
        .doc("budgetbar")
        .snapshots()
        .map((snap) => BudgetBar.fromFirestore(snap));
  }

  // budget centre informatique data

  Stream<budgetCentre> get budgetcentredata {
    return _Ref.collection('budget')
        .doc("budgetcentre")
        .snapshots()
        .map((snap) => budgetCentre.fromFirestore(snap));
  }
  // probleme data

  Stream<probleme> probleme_bar(String probleme_uid) {
    return _Ref.collection("problemes")
        .doc(probleme_uid)
        .snapshots()
        .map((event) => probleme.fromFirestore(event));
  }

  // list of problemes

  Stream<List<probleme>> list_probleme_bar(String user_uid) {
    return _Ref.collection("problemes")
        .where("user_uid", isEqualTo: user_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => probleme.fromFirestore(e)).toList());
  }

  Stream<problemeCentre> probleme_centre(String probleme_uid) {
    return _Ref.collection("problemes_centre")
        .doc(probleme_uid)
        .snapshots()
        .map((event) => problemeCentre.fromFirestore(event));
  }

  // list of problemes

  Stream<List<problemeCentre>> list_probleme_centre(String user_uid) {
    return _Ref.collection("problemes_centre")
        .where("user_uid", isEqualTo: user_uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => problemeCentre.fromFirestore(e)).toList());
  }

  Stream<List<probleme>> get tous_les_problemes_bar {
    return _Ref.collection("problemes").snapshots().map(
        (event) => event.docs.map((e) => probleme.fromFirestore(e)).toList());
  }

  Stream<List<problemeCentre>> get tous_les_problemes_centre {
    return _Ref.collection("problemes_centre").snapshots().map((event) =>
        event.docs.map((e) => problemeCentre.fromFirestore(e)).toList());
  }

  // vente data

  // list de vente d'un utilisateur pour petit model

  // list de vente pour grand modeles

  // enregistrer une nouvelle bierre

  Future<String> addNouvelBiar(
      String nom,
      String type,
      int prix_unitaire,
      int quantite_initial,
      int quantite_physique,
      int seuil_approvisionnement) async {
    try {
      await _Ref.collection("bierres").doc(type + nom).set({
        'nom': nom,
        'type': type,
        'time': DateTime.now(),
        'prix_unitaire': prix_unitaire,
        'quantite_initial': quantite_initial,
        'quantite_physique': quantite_physique,
        'seuil_approvisionnement': seuil_approvisionnement
      });

      return "Succes";
    } catch (e) {
      return "Failed";
    }
  }

  // enregistrer un probleme
  Future<String> addProbleme(String user_uid, String description) async {
    try {
      await _Ref.collection("users")
          .doc(user_uid)
          .collection("problemes")
          .add({'description': description, 'time': DateTime.now()});
      return "Succes";
    } catch (e) {
      return "Failed";
    }
  }

// enregistrer une vente
  Future<String> addVente(
      String user_uid,
      String bierre_id,
      String budget_uid,
      int quantite,
      int quantite_qui_etait_vendu,
      int montant_en_stock,
      String category,
      String nom_bierre,
      int prix_unitaire,
      int solde_total_bar,
      int quantite_physique_en_stock) async {
    try {
      if (quantite <= quantite_physique_en_stock) {
        await _Ref.collection("users")
            .doc(user_uid)
            .collection("ventes")
            .doc(bierre_id)
            .set({
          'nom_bierre': nom_bierre,
          'category': category,
          'quantite': quantite_qui_etait_vendu + quantite,
          'montant': montant_en_stock + quantite * prix_unitaire,
          'time': DateTime.now(),
        });

        await _Ref.collection("bierres").doc(bierre_id).update({
          'quantite_physique': quantite_physique_en_stock - quantite,
        });

        await _Ref.collection("budget").doc(budget_uid).update({
          'solde_total': solde_total_bar + (quantite * prix_unitaire),
        });

        return "Succes";
      } else {
        // ignore: prefer_interpolation_to_compose_strings
        return "Stock insuffisant";
      }
    } catch (e) {
      return "Failed";
    }
  }

  // enregistrer un nouveau stock

  Future<String> addnewstock(String bierre_id, int quantite_ajouter,
      int quantite_physique_en_stock, int quantite_initial) async {
    try {
      await _Ref.collection("bierres").doc(bierre_id).update({
        'quantite_physique': quantite_physique_en_stock + quantite_ajouter,
        'quantite_initial': quantite_initial + quantite_ajouter,
      });
      return "Succes)";
    } catch (e) {
      return "Failed";
    }
  }

  // mettre a jour un produit

  updatebierre(
      String bierre_id, String nom, int seuil_approvisionnement) async {
    final reference = _Ref.collection("bierres");
    await reference.doc(bierre_id).update({
      'nom': nom,
      'seuil_approvisionnement': seuil_approvisionnement,
    });
  }

  // add depense

  Future<String> addDepense(String description, int montant_depenser,
      String user_id, String budget_id, int depense_budget) async {
    try {
      await _Ref.collection("users").doc(user_id).collection("depenses").add({
        'created_at': DateTime.now(),
        'description': description,
        'montant': montant_depenser
      });

      await _Ref.collection("budget").doc(budget_id).update({
        'depense': depense_budget + montant_depenser,
      });

      return "Succes";
    } catch (e) {
      return "Failed";
    }
  }
}
