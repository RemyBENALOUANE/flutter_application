import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identifiant:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              readOnly: false, // Permet à l'utilisateur de modifier le champ
            ),
            SizedBox(height: 16),
            Text(
              'Mot de passe:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              obscureText: true, // Cache le texte pour le champ Mot de passe
              readOnly: false, // Permet à l'utilisateur de modifier le champ
            ),
          ],
        ),
      );
  }
}
