import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String id;
  final String titre;
  final String image;
  final String theme;
  final double prix;
  final String lieu;
  final int nombrePersonnesMin;

  Activity({
    required this.id,
    required this.titre,
    required this.image,
    required this.theme,
    required this.prix,
    required this.lieu,
    required this.nombrePersonnesMin,
  });

  factory Activity.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Activity(
      id: doc.id,
      titre: data['titre'] ?? '',
      image: data['image'] ?? '',
      theme: data['theme'] ?? '',
      prix: data['prix'] ?? 0.0,
      lieu: data['lieu'] ?? '',
      nombrePersonnesMin: data['nombrePersonnesMin'] ?? 0,
    );
  }
}

class ActivityPage extends StatefulWidget {
  final String userId;

  const ActivityPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late Future<List<Activity>> _activities;
  late List<String> _userCartActivities = [];

  @override
  void initState() {
    super.initState();
    _activities = _getActivitiesFromFirestore();
    _getUserCartActivities();
  }

  Future<List<Activity>> _getActivitiesFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('activity').get();
    return querySnapshot.docs
        .map((doc) => Activity.fromFirestore(doc))
        .toList();
  }

  Future<void> _addToCart(String userId, String activityId) async {
    try {
      await FirebaseFirestore.instance.collection('panier').add({
        'userId': userId,
        'activityId': activityId,
      });
      print('Activité ajoutée au panier avec succès!');
      _getUserCartActivities(); // Actualiser la liste des activités dans le panier après l'ajout
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'activité au panier: $e');
    }
  }

  Future<void> _getUserCartActivities() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('panier')
        .where('userId', isEqualTo: widget.userId)
        .get();
    setState(() {
      _userCartActivities = querySnapshot.docs
          .map((doc) => doc['activityId'] as String)
          .toList();
    });
  }

  bool _isActivityInUserCart(String activityId) {
    return _userCartActivities.contains(activityId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Activity>>(
      future: _activities,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Activity> activities = snapshot.data!;
            return ListView.builder(
              itemCount: activities.length,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            activities[index].image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.black.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activities[index].titre,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Lieu : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${activities[index].lieu}',
                                      ),
                                      TextSpan(
                                        text: '  Prix : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${activities[index].prix} €',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 48,
                          child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(20), // Ajustez le padding selon vos besoins
                                  title: Text(
                                    'Détails de l\'activité',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 62, 156),
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: double.infinity,
                                          height: 300, // Ajustez la hauteur de l'image selon vos besoins
                                          child: Image.network(
                                            activities[index].image,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.error); // Affiche une icône d'erreur en cas d'échec de chargement de l'image
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              'Titre: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16, // Ajustez la taille du texte selon vos besoins
                                                color: Color.fromARGB(255, 0, 62, 156),
                                              ),
                                            ),
                                            Text(
                                              '${activities[index].titre}',
                                              style: TextStyle(
                                                fontSize: 16, // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Thème: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color.fromARGB(255, 0, 62, 156), // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                            Text(
                                              '${activities[index].theme}',
                                              style: TextStyle(
                                                fontSize: 16, // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Lieu: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color.fromARGB(255, 0, 62, 156), // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                            Text(
                                              '${activities[index].lieu}',
                                              style: TextStyle(
                                                fontSize: 16, // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Prix: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color.fromARGB(255, 0, 62, 156), // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                            Text(
                                              '${activities[index].prix} €',
                                              style: TextStyle(
                                                fontSize: 16, // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Nombre de personnes minimum: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color.fromARGB(255, 0, 62, 156), // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                            Text(
                                              '${activities[index].nombrePersonnesMin}',
                                              style: TextStyle(
                                                fontSize: 18, // Ajustez la taille du texte selon vos besoins
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Fermer',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 62, 156),
                                          fontSize: 18, // Ajustez la taille du texte selon vos besoins
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.info_outline),
                          color: Colors.white,
                        ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: IconButton(
                            onPressed: () {
                              if (_isActivityInUserCart(activities[index].id)) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Cette activité est déjà dans votre panier'),
                                  backgroundColor: Color.fromARGB(255, 0, 62, 156),
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                _addToCart(widget.userId, activities[index].id);
                              }
                            },
                            icon: Icon(
                              _isActivityInUserCart(activities[index].id)
                                  ? Icons.shopping_cart
                                  : Icons.shopping_cart_outlined,
                            ),
                            color: _isActivityInUserCart(activities[index].id)
                                ? Colors.green
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
