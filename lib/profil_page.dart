import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
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
    );
  }
}