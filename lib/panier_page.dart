import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PanierPage extends StatefulWidget {
  final String userId;

  const PanierPage({Key? key, required this.userId}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  late List<DocumentSnapshot> panierItems = [];
  late double prixTotal = 0;

  @override
  void initState() {
    super.initState();
    _fetchPanierItems();
  }

  Future<void> _fetchPanierItems() async {
    QuerySnapshot panierSnapshot = await FirebaseFirestore.instance
        .collection('panier')
        .where('userId', isEqualTo: widget.userId)
        .get();
    setState(() {
      panierItems = panierSnapshot.docs;
    });

    prixTotal = 0;
    for (var panierItem in panierItems) {
      DocumentSnapshot activitySnapshot = await FirebaseFirestore.instance
          .collection('activity')
          .doc(panierItem['activityId'])
          .get();
      setState(() {
        prixTotal += activitySnapshot['prix'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return panierItems.isEmpty
        ? Center(
            child: Text(
              'Votre panier est vide',
              style: TextStyle(fontSize: 15),
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: panierItems.length, // +1 pour le prix total
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('activity')
                          .doc(panierItems[index]['activityId'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 2,
                            height: 200,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 62, 156)),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        var activityData =
                            snapshot.data!.data() as Map<String, dynamic>;
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
                                    activityData['image'],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          activityData['titre'],
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
                                                text:
                                                    '${activityData['lieu']}',
                                              ),
                                              TextSpan(
                                                text: '  Prix : ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${activityData['prix']} €',
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
                                  right: 8,
                                  child: IconButton(
                                    onPressed: () {
                                      deleteToPanier(panierItems[index].id);
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(10, 0, 62, 156),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    children: [
                      TextSpan(
                        text: 'Prix Total : ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 62, 156)),
                      ),
                      TextSpan(
                        text: '$prixTotal €',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 62, 156)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  void deleteToPanier(String panierItemId) {
    FirebaseFirestore.instance
        .collection('panier')
        .doc(panierItemId)
        .delete()
        .then((value) {
      setState(() {
        panierItems.removeWhere((item) => item.id == panierItemId);
      });
      _fetchPanierItems(); // Pour mettre à jour le prix total après la suppression
    }).catchError((error) => print("Failed to delete item: $error"));
  }
}
