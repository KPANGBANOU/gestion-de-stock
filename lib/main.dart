// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/liste_des_grands_modele.dart';
import 'package:projet/interface/Bar_restaurant/liste_petits_modele.dart';
import 'package:projet/interface/centre_informatique/centre_liquidite_list_credits.dart';
import 'package:projet/interface/centre_informatique/centre_vente_list_credits.dart';
import 'package:projet/interface/centre_informatique/centre_vente_list_produits.dart';
import 'package:projet/interface/centre_informatique/centre_vente_produit.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/credits_servants.dart';
import 'package:projet/modele/credits_vente.dart';
import 'package:projet/modele/depense_centre.dart';
import 'package:projet/modele/probleme.dart';
import 'package:projet/modele/probleme_centre.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';
import 'package:projet/modele/vente_tee_shirts.dart';

import 'package:projet/services/provider_recuperation_bierre_id.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'package:projet/parametres_admin.dart';

import 'base_donne/servicebasededonnees.dart';
import 'interface/Bar_restaurant/accueil_servant_bar.dart';
import 'interface/Bar_restaurant/bar_signaler_probleme.dart';
import 'interface/Bar_restaurant/benefices.dart';
import 'interface/Bar_restaurant/enregistrer_depense.dart';
import 'interface/Bar_restaurant/enregistrer_nouvel_bierre.dart';
import 'interface/Bar_restaurant/interface_bar_restaurant.dart';

import 'interface/Bar_restaurant/profil_utilisateur.dart';
import 'interface/accueil.dart';
import 'interface/centre_informatique/centre_approvisionner_list_produits.dart';
import 'interface/centre_informatique/centre_enregistrer_depense.dart';
import 'interface/centre_informatique/centre_enregistrer_nouveau_produit.dart';
import 'interface/centre_informatique/centre_enregistrer_nouveau_reseau_credit.dart';
import 'interface/centre_informatique/centre_enregistrer_probleme.dart';

import 'interface/centre_informatique/centre_approvisionnement.dart';
import 'interface/centre_informatique/centre_benefices.dart';
import 'interface/centre_informatique/centre_liquidite_credit.dart';
import 'interface/centre_informatique/centre_produits.dart';
import 'interface/centre_informatique/centre_rubrique_versement.dart';
import 'interface/centre_informatique/centre_statistique_vente.dart';
import 'interface/centre_informatique/centre_stock_physique.dart';
import 'interface/centre_informatique/centre_vente_credit.dart';
import 'interface/connexion.dart';
import 'interface/creer_compte.dart';

import 'interface/home.dart';
import 'interface/interface_centre_informatique.dart';
import 'interface/listes_utilisateurs.dart';

import 'interface/suppression_compte.dart';

import 'interface/wrapper.dart';
import 'interface/zoom.dart';
import 'modele/bieere_petit_model.dart';
import 'modele/bierre_grand_model.dart';
import 'modele/budgetBar.dart';
import 'modele/budget_centre.dart';
import 'modele/depense.dart';
import 'modele/donnesservants.dart';
import 'modele/produit.dart';
import 'services/change_admin_page.dart';
import 'services/change_page.dart';
import 'services/change_servant_page.dart';
import 'services/registration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String uid = "";

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
    }
    // ignore: dead_code
    return MultiProvider(
      providers: [
        Provider<firebaseAuth>(
          create: (_) => firebaseAuth(),
        ),
        StreamProvider(
            create: (context) => context.read<firebaseAuth>().utilisateur,
            initialData: null),
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) => context.read<serviceBD>().servantBar),
            initialData: <donnesServants>[]),
        StreamProvider(
            create: ((context) => context.read<serviceBD>().currentuserdata),
            /* catchError: ((context, error) {
              print(error.toString());
            })*/
            initialData: donnesUtilisateur(
                uid: "",
                nom: "",
                prenom: "",
                email: "",
                telephone: "",
                role: "",
                sexe: "",
                date_naissance: "",
                domaine: "",
                photo_url: "",
                admin: false,
                is_active: true)),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_vente_tee_shirts),
            initialData: <venteteeshirts>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_credits_vente_centre),
            initialData: <CreditsServants>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_ventes_credits),
            initialData: <venteCredit>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_ventes_grand_modeles),
            initialData: <venteGrandModele>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_ventes_petit_modeles),
            initialData: <ventePetitModele>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_ventes_produits),
            initialData: <centreVente>[]),

        StreamProvider(
            create: ((context) => context.read<serviceBD>().budgetBardata),
            initialData:
                BudgetBar(benefice: 0, solde_total: 0, depense: 0, uid: "")),
        StreamProvider(
            create: (context) => context.read<serviceBD>().budgetcentredata,
            initialData:
                budgetCentre(benefice: 0, solde_total: 0, depense: 0, uid: "")),
        // list ge grand modeles de bierres
        StreamProvider(
            create: ((context) => context.read<serviceBD>().lisBiarGrandModel),
            initialData: const <donnesBierresGrandModel>[]),
        // list de petit model de bierres

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().listDonnesBierresPetitModele),
            initialData: const <donneesBieerePetitModele>[]),

        StreamProvider(
            create: ((context) => context.read<serviceBD>().list_tee_shirts),
            initialData: <serigraphie>[]),

        // list de vente

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_depense_centre),
            initialData: const <DepenseCentre>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_depenses_bar),
            initialData: <donnesDepense>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_problemes_bar),
            initialData: <probleme>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tous_les_problemes_centre),
            initialData: <problemeCentre>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_credits_vente_bar),
            initialData: <CreditsVente>[]),

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_produits_centre),
            initialData: <CreditsServants>[]),
        // list of user

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_reseaux_credits),
            initialData: <credit>[]),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_produits_centre),
            initialData: <products>[]),

        StreamProvider(
            create: (context) =>
                context.read<serviceBD>().listDonnesUtilisateur,
            initialData: const <donnesUtilisateur>[]),

        ChangeNotifierProvider(create: (context) => changingPage()),
        ChangeNotifierProvider(create: (context) => changingServantPage()),
        ChangeNotifierProvider(create: (context) => changingAdminPage()),
        ChangeNotifierProvider(create: ((context) => changbierreid())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/wrapper": (context) => Wrapper(),
            "/accueil": (context) => Accueil(),
            "/accueilservant": (context) => AccueilServantBar(),
            "/creercompte": (context) => RegisterPage(),
            "/bar": (context) => Bar(),
            "/centreInformatique": (context) => CentreInterfacePage(),
            "/zoom": (context) => Zoom(),
            "/listeEmployes": (context) => ListeUtilisateurs(),
            "/home": (context) => HomePage(),
            "/barbenefices": (context) => BeneficeBar(),
            "/login": (context) => LoginPage(),
            "/barsavanewproduct": (context) =>
                EnregistrerNouvelBierreFormPage(),
            "/barenregistrerdepense": (context) => BarEnregistrerDepense(),
            "/barsignalerprobleme": (context) => BarSignalerProbleme(),
            "/profil": (context) => ProfilUtilisateur(),
            "/parametresadmin": (context) => ParametresAdmin(),
            "/listedesgrandsmodeles": (context) => ListeDesGrandModel(),
            "/listedespetitsmodeles": (context) => ListeDesPetitsModel(),
            "/supprimercompte": (context) => SuppressionCompte(),
            "/centrebenefices": (context) => CentreBenefices(),
            "/centrestatistiquevente": (context) => CentreStatistiqueVente(),
            "/centrerubriqueversement": (context) => CentreRubriqueVersement(),
            "/centreproduits": (context) => CentreListProduits(),
            "/centreventecredit": (context) => CentreVenteCredit(),
            "/centreventelistproduit": (context) => CentreVenteListProduits(),
            "/centreventeproduit": (context) => CentreVenteProduits(),
            "/centreventelistcredits": (context) => CentreVenteListCredits(),
            "/centreliquiditecredit": (context) => CentreLiquiditeCredit(),
            "/centreliquiditelistcredit": (context) =>
                CentreLiquiditeListCredits(),
            "/centreenregistrerdepense": (context) =>
                CentreEnregistrerDepense(),
            "/centreenregistrerprobleme": (context) =>
                CentreEnregistrerProbleme(),
            "/centreenregistrernouveauproduit": (context) =>
                CentreEnregistrerNouveauProduit(),
            "/centreenregistrernouveaureseaucredit": (context) =>
                CentreEnregistrerNouveauReseauCredit(),
            "/centrestockphysique": (context) =>
                CentreStockPhysiqueListProduits(),
            "/centreapprovisionnement": (context) => CentreApprovisionnement(),
            "/centreapprovisionnementlistproduits": (context) =>
                CentreApprovisionnerListProduits(),
          },
          initialRoute: "/wrapper"),
    );
  }
}
