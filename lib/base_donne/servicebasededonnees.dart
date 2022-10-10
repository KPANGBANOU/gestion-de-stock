// ignore_for_file: camel_case_types, dead_code, prefer_final_fields, prefer_typing_uninitialized_variables, empty_constructor_bodies, non_constant_identifier_names, unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';

import 'package:projet/modele/budgetBar.dart';
import 'package:projet/modele/budget_centre.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/credit.dart';

import 'package:projet/modele/depense.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/modele/probleme.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';
import 'package:projet/modele/vente_tee_shirt_grande_qualite.dart';
import 'package:projet/modele/vente_tee_shirt_qualite_faible.dart';
import 'package:projet/modele/vente_tee_shirt_qualite_moyenne.dart';

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

  Stream<List<venteteeshirtsgrandequalite>> list_vente_tee_shirt_grande_qualite(
      String user_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection("vente_tee_shirts")
        .where("qualite", isEqualTo: "Grande qualité")
        .snapshots()
        .map((event) => event.docs
            .map((e) => venteteeshirtsgrandequalite.fromfirestore(e))
            .toList());
  }

  Stream<venteteeshirtsgrandequalite> vente_tee_shirt_grande_qualite(
      String user_uid, String vente_tee_shirt_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection('vente_tee_shirts')
        .doc(vente_tee_shirt_uid)
        .snapshots()
        .map((event) => venteteeshirtsgrandequalite.fromfirestore(event));
  }

  Stream<List<venteteeshirtsqualitemoyenne>>
      list_vente_tee_shirt_qualite_moyenne(String user_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection("vente_tee_shirts")
        .where("qualite", isEqualTo: "Qualité moyenne")
        .snapshots()
        .map((event) => event.docs
            .map((e) => venteteeshirtsqualitemoyenne.fromfirestore(e))
            .toList());
  }

  Stream<venteteeshirtsqualitemoyenne> vente_tee_shirt_qualite_moyenne(
      String user_uid, String vente_tee_shirt_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection('vente_tee_shirts')
        .doc(vente_tee_shirt_uid)
        .snapshots()
        .map((event) => venteteeshirtsqualitemoyenne.fromfirestore(event));
  }

  Stream<List<venteteeshirtsqualitefaible>> list_vente_tee_shirt_qualite_faible(
      String user_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection("vente_tee_shirts")
        .where("qualite", isEqualTo: "Faible qualité")
        .snapshots()
        .map((event) => event.docs
            .map((e) => venteteeshirtsqualitefaible.fromfirestore(e))
            .toList());
  }

  Stream<venteteeshirtsqualitefaible> vente_tee_shirt_qualite_faible(
      String user_uid, String vente_tee_shirt_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection('vente_tee_shirts')
        .doc(vente_tee_shirt_uid)
        .snapshots()
        .map((event) => venteteeshirtsqualitefaible.fromfirestore(event));
  }

  // liste de produits

  Stream<List<products>> get list_produits_centre {
    return _Ref.collection("produits_centre").snapshots().map(
        (event) => event.docs.map((e) => products.fromFirestore(e)).toList());
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
    return _Ref.collection("users")
        .doc(employe_uid)
        .collection("centre_vente_produits")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => centreVente.fromfirestore(e)).toList());
  }

  Stream<List<ventePetitModele>> list_vente_petit_modele(String employe_uid) {
    return _Ref.collection("users")
        .doc(employe_uid)
        .collection("ventes")
        .where("type", isEqualTo: "Pétit modèle")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ventePetitModele.fromFirestore(e)).toList());
  }

  Stream<ventePetitModele> vente_petit_modele(
      String employe_uid, String bierre_uid) {
    return _Ref.collection("users")
        .doc(employe_uid)
        .collection("ventes")
        .doc(bierre_uid)
        .snapshots()
        .map((event) => ventePetitModele.fromFirestore(event));
  }

  Stream<List<venteGrandModele>> list_vente_grand_modele(String employe_uid) {
    return _Ref.collection("users")
        .doc(employe_uid)
        .collection("ventes")
        .where("type", isEqualTo: "Grand modèle")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => venteGrandModele.fromFirestore(e)).toList());
  }

  Stream<venteGrandModele> vente_grand_modele(
      String employe_uid, String bierre_uid) {
    return _Ref.collection("users")
        .doc(employe_uid)
        .collection("ventes")
        .doc(bierre_uid)
        .snapshots()
        .map((event) => venteGrandModele.fromFirestore(event));
  }

  // ventre centre

  Stream<centreVente> centre_vente_produit(
      String employe_uid, String produit_uid) {
    return _Ref.collection("users")
        .doc(employe_uid)
        .collection("centre_vente_produits")
        .doc(produit_uid)
        .snapshots()
        .map((event) => centreVente.fromfirestore(event));
  }

  Stream<List<venteCredit>> list_vente_credits(String employe_uid) {
    return _Ref.collection("users")
        .doc(employe_uid)
        .collection("vente_credits")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => venteCredit.fromFirestore(e)).toList());
  }

  Stream<venteCredit> vente_credit(String user_uid, String credit_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection("vente_credits")
        .doc(credit_uid)
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
  Stream<List<donnesDepense>> mesdepense(String uid) {
    return _Ref.collection("users")
        .doc(uid)
        .collection("depenses")
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => donnesDepense.fromFirestore(e)).toList());
  }

  // list of depense par employé

  Stream<List<donnesDepense>> depensedechaqueemploye(String user_id) {
    return _Ref.collection("users")
        .doc(user_id)
        .collection("depenses")
        .snapshots()
        .map((documents) => documents.docs
            .map((snap) => donnesDepense.fromFirestore(snap))
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

  Stream<probleme> problemedata(String uid) {
    return _Ref.collection("problemes")
        .doc(uid)
        .snapshots()
        .map((event) => probleme.fromFirestore(event));
  }

  // list of problemes

  Stream<List<probleme>> get listProblemes {
    return _Ref.collection("problemes").snapshots().map(
        (event) => event.docs.map((e) => probleme.fromFirestore(e)).toList());
  }

  // vente data

  // list de vente d'un utilisateur pour petit model

  Stream<List<ventePetitModele>> list_vente_servant_bar_petit_modele(
      String user_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection("ventes")
        .where('type', isEqualTo: 'Pétit modèle')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ventePetitModele.fromFirestore(e)).toList());
  }

  // list de vente pour grand modeles

  Stream<List<venteGrandModele>> list_vente_servant_bar_grand_modele(
      String user_uid) {
    return _Ref.collection("users")
        .doc(user_uid)
        .collection("ventes")
        .where('type', isEqualTo: 'Grand modèle')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => venteGrandModele.fromFirestore(e)).toList());
  }

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
