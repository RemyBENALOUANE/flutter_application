import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String id;
  final String titre;
  final String image;
  final String theme;
  final double prix;
  final String lieu;
  final int nombreMinimumPersonnes;

  Activity({
    required this.id,
    required this.titre,
    required this.image,
    required this.theme,
    required this.prix,
    required this.lieu,
    required this.nombreMinimumPersonnes,
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
      nombreMinimumPersonnes: data['nombreMinimumPersonnes'] ?? 0,
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

  @override
  void initState() {
    super.initState();
    _activities = _getActivitiesFromFirestore();
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
      final alreadyInCart = await _isActivityInCart(userId, activityId);
      if (alreadyInCart) {
        print('L\'activité est déjà dans le panier!');
      } else {
        await FirebaseFirestore.instance.collection('panier').add({
          'userId': userId,
          'activityId': activityId,
        });
        print('Activité ajoutée au panier avec succès!');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'activité au panier: $e');
    }
  }

  Future<bool> _isActivityInCart(String userId, String activityId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('panier')
          .where('userId', isEqualTo: userId)
          .where('activityId', isEqualTo: activityId)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Erreur lors de la vérification de l\'activité dans le panier: $e');
      return false;
    }
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
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
                              print('${widget.userId}');
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
                              _addToCart(widget.userId, activities[index].id);
                            },
                            icon: Icon(Icons.shopping_cart_outlined),
                            color: Colors.white,
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
