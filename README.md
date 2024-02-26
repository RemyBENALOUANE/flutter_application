# Application Flutter pour Activités de Groupe

Cette application Flutter permet aux utilisateurs de découvrir et de participer à des activités de groupe. Que vous planifiez une journée entre amis ou que vous recherchiez de nouvelles expériences de groupe, cette application est faite pour vous.

## Fonctionnalités

1. **Connexion Utilisateur :** Les utilisateurs peuvent se connecter à l'application à l'aide de leurs identifiants.
   
2. **Ajout d'Activités au Panier :** Les utilisateurs peuvent parcourir les activités disponibles et ajouter celles qui les intéressent à leur panier grâce au bouton avec l'icone de panier.

3. **Détails d'une Activité :** Les utilisateurs peuvent consulter les détails de chaque activité pour en savoir plus avant de les ajouter à leur panier grâce au bouton avec l'icone information.

4. **Filtrage par Thème :** Les activités peuvent être filtrées en fonction de différents thèmes pour une recherche plus ciblée.

5. **Consultation du Panier :** Les utilisateurs peuvent voir le contenu de leur panier, ainsi que le prix total des activités ajoutées.

6. **Suppression d'une Activité du Panier :** Les utilisateurs ont la possibilité de supprimer des activités de leur panier s'ils changent d'avis.

7. **Modification des Informations Personnelles :** Les utilisateurs peuvent mettre à jour leurs informations personnelles, y compris leur code postal.

8. **Déconnexion :** Les utilisateurs peuvent se déconnecter de leur compte.

## Détails Additionnels

- **Logo :** Un logo distinctif a été ajouté pour l'application, offrant une identité visuelle reconnaissable.

- **Filtres dynamiques :** Les filtres sont dynamiques: on peut ajouter plusieurs filtre en même temps et les désélectionner.

- **Panier associé à un utlisateur :** Chaque panier est associé à un utilisateur unique.
  
- **Vérification du Code Postal :** Un contrôle est effectué lors de la saisie du code postal pour s'assurer qu'il comporte bien 5 chiffres.

- **Messages d'erreur :** Des messages d'erreur ou de succès apparaissent à différents moments pour informer l'utilisateur.

- **Ajout d'activités unique au panier :** Une activité ne peut être ajoutée qu'une seule fois au panier, un message apparait si l'activité est déjà dans le panier. L'icone du panier se met à jour en focntion de si l'activité est déjà ajoutée.

- **Message panier vide :** Un message spécifique est affiché si le panier est vide et le total disparait.

## Firebase

L'application est connectée à Firebase pour stocker les données utilisateur, les détails des activités et les informations relatives aux paniers.

## Captures d'Écran

<img width="936" alt="Capture d'écran 2024-02-26 161642" src="https://github.com/RemyBENALOUANE/flutter_application/assets/66668680/234adbb0-8d89-4665-9237-64ea1015af5f">

<img width="932" alt="Capture d'écran 2024-02-26 161734" src="https://github.com/RemyBENALOUANE/flutter_application/assets/66668680/a6ac4965-ffc6-498d-9f5d-f011d1feecfa">

<img width="935" alt="Capture d'écran 2024-02-26 161753" src="https://github.com/RemyBENALOUANE/flutter_application/assets/66668680/c1ef0a2a-346d-4f5b-bebc-77ab3f0c85db">

<img width="932" alt="Capture d'écran 2024-02-26 164543" src="https://github.com/RemyBENALOUANE/flutter_application/assets/66668680/dd8329f4-bb15-4ef0-92b7-5cd59e4613f2">


## Captures d'Écran de la Base de Données

*(Insérez les captures d'écran de la base de données ici)*

## Installation

1. Clonez le dépôt : `git clone https://github.com/votre/repository.git`
2. Accédez au répertoire du projet.
3. Exécutez `flutter pub get` pour installer les dépendances.
4. Assurez-vous que Firebase est configuré et correctement mis en place pour le projet.
5. Lancez l'application avec `flutter run`.

## Users

login: user1
password: 123456789

login: user2
password: 123456789
