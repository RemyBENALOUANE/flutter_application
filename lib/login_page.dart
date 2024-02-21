import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navigation_wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginFunction(BuildContext context) async {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      try {
        // Accéder à la collection "users" dans Firestore et chercher l'utilisateur avec l'email donné
        final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('login', isEqualTo: email)
            .where('password', isEqualTo: password)
            .get();

        // Vérifier si un utilisateur correspondant à l'email donné existe
        if (snapshot.docs.isNotEmpty) {
          final userId = snapshot.docs.first.id; // Récupérer l'ID de l'utilisateur connecté
          print("ID utilisateur: $userId'");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Connexion'),
              duration: Duration(seconds: 1),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationWrapper(userId: userId)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Identifiant ou mot de passe incorrect'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (error) {
        print('Erreur lors de la connexion: $error');
      }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Color.fromARGB(255, 0, 62, 156), // Couleur de fond du headerBar
          child: Center(
            child: Image.asset(
              '../assets/logo.png', // Remplacez ceci par le chemin de votre logo
              height: 80, // Ajustez selon votre préférence
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Connexion",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 62, 156),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.mail_rounded, color: Color.fromARGB(255, 0, 62, 156))
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 0, 62, 156))
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => loginFunction(context),
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
