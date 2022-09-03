// ignore_for_file: camel_case_types, dead_code, prefer_final_fields, prefer_typing_uninitialized_variables, empty_constructor_bodies, non_constant_identifier_names, unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:projet/modele/budget.dart';
import 'package:projet/modele/budgetBar.dart';
import 'package:projet/modele/budget_centre.dart';

import 'package:projet/modele/depense.dart';
import 'package:projet/modele/probleme.dart';
import 'package:projet/modele/vente.dart';
import 'package:projet/services/user.dart';

class serviceBD {
  final FirebaseFirestore _Ref = FirebaseFirestore.instance;
// user data
  Stream<donnesUtilisateur> donnes(String uid) {
    return _Ref.collection("users")
        .doc(uid)
        .snapshots()
        .map((snap) => donnesUtilisateur.fromFiresotre(snap));
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
    return _Ref.collection("bierres").snapshots().map((documents) => documents
        .docs
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
    return _Ref.collection("bierres").snapshots().map((documents) => documents
        .docs
        .map((snap) => donnesBierresGrandModel.fromFirestore(snap))
        .toList());
  }

  // budget general data

  Stream<budget> get budgetGeneral {
    return _Ref.collection("budget")
        .doc("budgetgenerale")
        .snapshots()
        .map((snap) => budget.fromFirestore(snap));
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

  Stream<vente> ventedata(String uid) {
    return _Ref.collection("ventes")
        .doc(uid)
        .snapshots()
        .map((event) => vente.fromFirestore(event));
  }

  // list de vente

  Stream<List<vente>> get listdevente {
    return _Ref.collection("ventes")
        .snapshots()
        .map((event) => event.docs.map((e) => vente.fromFirestore(e)).toList());
  }

  // enregistrer une nouvelle bierre

  addNouvelBiar(
      String nom,
      String type,
      int prix_unitaire,
      int quantite_initial,
      int quantite_physique,
      int seuil_approvisionnement) async {
    await _Ref.collection("bierres").add({
      'nom': nom,
      'type': type,
      'time': DateTime.now(),
      'prix_unitaire': prix_unitaire,
      'quantite_initial': quantite_initial,
      'quantite_physique': quantite_physique,
      'seuil_approvisionnement': seuil_approvisionnement
    });
    // enregistrer un probleme
    addProbleme(String uid, String description) async {
      await _Ref.collection("users")
          .doc(uid)
          .collection("problemes")
          .add({'description': description, 'time': DateTime.now()});
    }

// enregistrer une vente
    addVente(String uid, String bierre_id, int quantite, int montant,
        int budget_bar, int quantite_physique_bierre) async {
      if (quantite <= quantite_physique_bierre) {
        await _Ref.collection("users").doc(uid).collection("ventes").add({
          'bierre_id': bierre_id,
          'quantite': quantite,
          'montant': montant,
          'time': DateTime.now(),
        });

        await _Ref.collection("bierres").doc(bierre_id).update({
          'quantite_physique': quantite_physique_bierre - quantite,
        });

        await _Ref.collection("budget_bar").doc("budgetbar").update({
          'solde_total': budget_bar + montant,
        });
      }
    }
  }

  // enregistrer un nouveau stock

  addnewstock(String bierre_id, int quantite_ajouter,
      int quantite_physique_en_stock, int quantite_initial) async {
    await _Ref.collection("bierres").doc(bierre_id).update({
      'quantite_physique': quantite_physique_en_stock + quantite_ajouter,
      'quantite_initialn': quantite_initial + quantite_ajouter,
    });
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

  addDepense(String description, int montant, String user_id, String budget_id,
      int depense) async {
    await _Ref.collection("users").doc(user_id).collection("depenses").add({
      'created_at': DateTime.now(),
      'description': description,
      'montant': montant
    });

    await _Ref.collection("budget").doc(budget_id).update({
      'depense': depense + montant,
    });
  }
}
