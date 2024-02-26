import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class ProfilPage extends StatefulWidget {
  final String userId;

  const ProfilPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late TextEditingController _anniversaireController;
  late TextEditingController _adresseController;
  late TextEditingController _codePostalController;
  late TextEditingController _villeController;

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs de texte
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _anniversaireController = TextEditingController();
    _adresseController = TextEditingController();
    _codePostalController = TextEditingController();
    _villeController = TextEditingController();

    // Charger les données de l'utilisateur depuis Firebase
    loadUserData();
  }

  @override
  void dispose() {
    // Libérer les ressources des contrôleurs de texte
    _loginController.dispose();
    _passwordController.dispose();
    _anniversaireController.dispose();
    _adresseController.dispose();
    _codePostalController.dispose();
    _villeController.dispose();
    super.dispose();
  }

  void loadUserData() async {
    // Récupérer les données de l'utilisateur depuis Firebase
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(widget.userId).get();

    // Vérifier si le document existe
    if (userSnapshot.exists) {
      setState(() {
        _loginController.text = userSnapshot['login'] ?? '';
        _passwordController.text = userSnapshot['password'] ?? '';
        
        // Vérifier et utiliser les autres champs s'ils existent
        final userData = userSnapshot.data();
        if (userData != null) {
          if (userData.containsKey('anniversaire')) {
            _anniversaireController.text = userData['anniversaire'];
          }
          if (userData.containsKey('adresse')) {
            _adresseController.text = userData['adresse'];
          }
          if (userData.containsKey('codePostal')) {
            _codePostalController.text = userData['codePostal'];
          }
          if (userData.containsKey('ville')) {
            _villeController.text = userData['ville'];
          }
        }
      });
    } else {
      // Gérer le cas où le document n'existe pas
      print('Document non trouvé');
    }
  }

  // Fonction pour gérer la déconnexion de l'utilisateur
  void logoutFunction() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20), // Ecarte les champs
            TextField(
              controller: _loginController,
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 62, 156)), // Couleur du label
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 62, 156)), // Couleur de la bordure lorsque le champ est sélectionné
                ),
              ),
            ),
            SizedBox(height: 10), // Ecarte les champs
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 62, 156)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 62, 156)),
                ),
              ),
            ),
            SizedBox(height: 10), // Ecarte les champs
            TextField(
              controller: _anniversaireController,
              decoration: InputDecoration(
                labelText: 'Anniversaire',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 62, 156)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 62, 156)),
                ),
              ),
            ),
            SizedBox(height: 10), // Ecarte les champs
            TextField(
              controller: _adresseController,
              decoration: InputDecoration(
                labelText: 'Adresse',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 62, 156)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 62, 156)),
                ),
              ),
            ),
            SizedBox(height: 10), // Ecarte les champs
            TextField(
              controller: _codePostalController,
              decoration: InputDecoration(
                labelText: 'Code Postal',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 62, 156)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 62, 156)),
                ),
              ),
            ),
            SizedBox(height: 10), // Ecarte les champs
            TextField(
              controller: _villeController,
              decoration: InputDecoration(
                labelText: 'Ville',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 62, 156)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 62, 156)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Mettre à jour les données de l'utilisateur sur Firebase
                  updateUserData();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 62, 156), // Couleur bleu foncé
                ),
                child: Text(
                  'Enregistrer',
                  style: TextStyle(
                    color: Colors.white, // Couleur du texte en blanc
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color.fromARGB(162, 228, 0, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Déconnexion
              logoutFunction();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 228, 0, 0),
              onPrimary: Colors.white,
            ),
            child: Text('Se déconnecter'),
          ),
        ),
      ),
    );
  }

  void updateUserData() async {
    // Vérifier si le code postal est un nombre
    if (!isNumeric(_codePostalController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Le code postal doit être un nombre'),
          backgroundColor: Color.fromARGB(255, 228, 0, 0),
          duration: Duration(seconds: 4),
        ),
      );
      return;
    }

    // Mettre à jour les données de l'utilisateur sur Firebase
    await FirebaseFirestore.instance.collection('user').doc(widget.userId).set({
      'login': _loginController.text,
      'password': _passwordController.text,
      'anniversaire': _anniversaireController.text,
      'adresse': _adresseController.text,
      'codePostal': _codePostalController.text,
      'ville': _villeController.text,
    }, SetOptions(merge: true));

    // Afficher un snackbar pour indiquer que les données ont été mises à jour
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Les informations du profil ont été mises à jour'),
        backgroundColor: Color.fromARGB(255, 0, 62, 156),
      ),
    );
  }

  // Fonction utilitaire pour vérifier si une chaîne est numérique
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
