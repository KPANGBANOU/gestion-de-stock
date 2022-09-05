// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/approvisionnement_list_petit_modele.dart';
import 'package:projet/interface/Bar_restaurant/approvisonnement_list_grand_modele.dart';
import 'package:provider/provider.dart';

import 'package:projet/parametres_admin.dart';

import 'base_donne/servicebasededonnees.dart';
import 'interface/Bar_restaurant/accueil_servant_bar.dart';
import 'interface/Bar_restaurant/approvisionnement.dart';
import 'interface/Bar_restaurant/bar_approvisionner_grand_modele.dart';
import 'interface/Bar_restaurant/bar_signaler_probleme.dart';
import 'interface/Bar_restaurant/benefices.dart';
import 'interface/Bar_restaurant/depenses.dart';
import 'interface/Bar_restaurant/enregistrer_depense.dart';
import 'interface/Bar_restaurant/enregistrer_nouvel_bierre.dart';
import 'interface/Bar_restaurant/enregistrer_nouvel_stock.dart';
import 'interface/Bar_restaurant/interface_bar_restaurant.dart';
import 'interface/Bar_restaurant/liste_bierres.dart';
import 'interface/Bar_restaurant/liste_produits.dart';
import 'interface/Bar_restaurant/nouveau_approvisionnement.dart';
import 'interface/Bar_restaurant/pertes.dart';
import 'interface/Bar_restaurant/profil_utilisateur.dart';
import 'interface/Bar_restaurant/rubrique_versement.dart';
import 'interface/Bar_restaurant/statistique_des_ventes_bar.dart';

import 'interface/Bar_restaurant/stock_physique.dart';
import 'interface/Bar_restaurant/stockphysiquegrandmodel.dart';
import 'interface/Bar_restaurant/stockphysiquepetitmodel.dart';
import 'interface/Bar_restaurant/vente_bierre_grand_model.dart';
import 'interface/Bar_restaurant/vente_bierre_petit_model.dart';
import 'interface/accorder_droit.dart';
import 'interface/accueil.dart';
import 'interface/connexion.dart';
import 'interface/creer_compte.dart';
import 'interface/home.dart';
import 'interface/information_employe.dart';
import 'interface/interface_centre_informatique.dart';
import 'interface/listes_utilisateurs.dart';
import 'interface/mes_services.dart';

import 'interface/nouveau_service.dart';

import 'interface/welcome.dart';
import 'interface/wrapper.dart';
import 'interface/zoom.dart';
import 'modele/bieere_petit_model.dart';
import 'modele/bierre_grand_model.dart';
import 'modele/budgetBar.dart';
import 'modele/budget_centre.dart';
import 'modele/depense.dart';
import 'services/change_admin_page.dart';
import 'services/change_page.dart';
import 'services/change_servant_page.dart';
import 'services/registration.dart';
import 'services/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return MultiProvider(
      providers: [
        Provider<firebaseAuth>(
          create: (_) => firebaseAuth(),
        ),
        Provider<serviceBD>(
          create: (_) => serviceBD(),
        ),
        // donnees de l'utilisateur

        // donnes de l'utilisateur courament connecté
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .donnes(FirebaseAuth.instance.currentUser!.uid)),
            initialData: donnesUtilisateur(
                nom: "",
                prenom: "",
                email: "",
                telephone: "",
                role: "",
                sexe: "",
                date_naissance: "",
                admin: false,
                is_active: true)),
        StreamProvider(
            create: (context) => context.read<firebaseAuth>().utilisateur,
            initialData: null),
        // stream of budget bar

        StreamProvider(
            create: ((context) => context.read<serviceBD>().budgetBardata),
            initialData: BudgetBar(solde_total: 0, depense: 0, uid: "")),

        // stream of budget centre
        StreamProvider(
            create: (context) => context.read<serviceBD>().budgetcentredata,
            initialData: budgetCentre(solde_total: 0, depense: 0, uid: "")),
        // list ge grand modeles de bierres
        StreamProvider(
            create: ((context) => context.read<serviceBD>().lisBiarGrandModel),
            initialData: const <donnesBierresGrandModel>[]),
        // list de petit model de bierres

        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().listDonnesBierresPetitModele),
            initialData: const <donneesBieerePetitModele>[]),

        // list de vente

        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .mesdepense(FirebaseAuth.instance.currentUser!.uid)),
            initialData: const <donnesDepense>[]),
        // list of user

        StreamProvider(
            create: (context) =>
                context.read<serviceBD>().listDonnesUtilisateur,
            initialData: const <donnesUtilisateur>[]),

        ChangeNotifierProvider(create: (context) => changingPage()),
        ChangeNotifierProvider(create: (context) => changingServantPage()),
        ChangeNotifierProvider(create: (context) => changingAdminPage()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          color: Colors.cyan,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            "/wrapper": (context) => Wrapper(),
            "/accueil": (context) => Accueil(),
            "/accueilservant": (context) => AccueilServantBar(),
            "/creercompte": (context) => RegisterPage(),
            "/bar": (context) => Bar(),
            "/centreInformatique": (context) => CentreInterfacePage(),
            "/mesServices": (context) => MesServices(),
            "/zoom": (context) => Zoom(),
            "/listeEmployes": (context) => ListeUtilisateurs(),
            "/infoEmploye": (context) => InfoEmploye(),
            "/accorderDroits": (context) => DroitsEmployes(),
            "/home": (context) => HomePage(),
            "/barstockphysique": (context) => StockPhysique(),
            "/barrubrique": (context) => RubriqueVersement(),
            "/barbenefices": (context) => BeneficeBar(),
            "/bardepenses": (context) => DepensesBar(),
            "/barpertes": (context) => PertesBar(),
            "/barapprovisionnement": (context) => ApprovisionnementBar(),
            "/barstatistiquedesventes": (context) => StatistiqueDesVentesBar(),
            "/barlisteproduits": (context) => ListeProduits(),
            "/barnouveauapprovisionnement": (context) =>
                NouveauApprovisionnement(),
            "/barstockphysiquepetitmodele": (context) =>
                StockPhysiquePetitModel(),
            "/barstockphysiquegrandmodele": (context) =>
                StockPhysiqueGrandModel(),
            "/welcome": (context) => WelcomePage(),
            "/login": (context) => LoginPage(),
            "/barsavanewproduct": (context) =>
                EnregistrerNouvelBierreFormPage(),
            "/barsavenewstock": (context) =>
                BarEnregistrerNouvelStockFormPage(),
            "/barlistebierres": (context) => BarListeBierresPage(),
            "/barventepetitmodel": (context) => BarVenteBierrePetitModel(),
            "/barventegrandmodel": (context) => BarVenteBierreGrandModel(),
            "/barenregistrerdepense": (context) => BarEnregistrerDepense(),
            "/barsignalerprobleme": (context) => BarSignalerProbleme(),
            "/profil": (context) => ProfilUtilisateur(),
            "/parametresadmin": (context) => ParametresAdmin(),
            "/nouveauservice": (context) => NouveauService(),
            "/barsavenewstockgrandmodele": (context) =>
                BarApprovisionnerGrandModele(),
            "/approvisionnementlistgrandmodele": (context) =>
                ApprovisionnementListGrandModel(),
            "/approvisionnementlistpetitmodele": (context) =>
                ApprovisionnementListPetitModele()
          },
          initialRoute: "/wrapper"),
    );
  }
}
