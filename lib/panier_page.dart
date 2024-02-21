import 'package:flutter/material.dart';

class DataModel {
  final int id;
  final String titre;
  final String image;
  final String theme;
  final double prix;
  final String lieu;
  final int nombreMinimumPersonnes;

  DataModel({
    required this.id,
    required this.titre,
    required this.image,
    required this.theme,
    required this.prix,
    required this.lieu,
    required this.nombreMinimumPersonnes,
  });
}

class Panier {
  final int id;
  final int userId;
  final int dataModelId;

  Panier({
    required this.id,
    required this.userId,
    required this.dataModelId,
  });
}

final todoList = [
  DataModel(
    id: 1,
    titre: 'Foot',
    image: 'https://cdn.resfu.com/media/img_news/payet-marca-gol-en-el-olympique-marseille-paok-de-conference-league--captura-movistarligadecampeones.jpg',
    theme: 'Sport',
    prix: 10.0,
    lieu: 'Antibes',
    nombreMinimumPersonnes: 10,
  ),
  DataModel(
    id: 2,
    titre: 'Burger King',
    image: 'https://rs-menus-api.roocdn.com/images/2f376562-2cd9-45b4-991b-7b3c2d418ef1/image.jpeg',
    theme: 'Restauration',
    prix: 15.0,
    lieu: 'Vence',
    nombreMinimumPersonnes: 2,
  ),
  DataModel(
    id: 3,
    titre: 'Plage',
    image: 'https://woody.cloudly.space/app/uploads/crt-paca/2020/07/thumbs/nice-paca-credit-fotolia-1-1920x960.jpg',
    theme: 'Nature',
    prix: 0,
    lieu: 'Nice',
    nombreMinimumPersonnes: 1,
  ),
  DataModel(
    id: 4,
    titre: 'Musée des Beaux-Arts',
    image: 'https://upload.wikimedia.org/wikipedia/commons/d/d4/Villa_Thomson_03.jpg',
    theme: 'Culture',
    prix: 5,
    lieu: 'Nice',
    nombreMinimumPersonnes: 4,
  ),
  DataModel(
    id: 5,
    titre: 'Cinéma',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6giqukVT9hl4NF8RAK-_G9zdIJ1RatG3qZw&usqp=CAU',
    theme: 'Divertissement',
    prix: 10.0,
    lieu: 'Roquebrune-Cap-Martin',
    nombreMinimumPersonnes: 6,
  ),
  DataModel(
    id: 6,
    titre: 'Balade en forêt',
    image: 'https://www.tourisme-labenne.com/wp-content/uploads/sites/3/2021/11/foret-labenne-rando.jpg',
    theme: 'Nature',
    prix: 0.0,
    lieu: 'Beaulieu-sur-Mer',
    nombreMinimumPersonnes: 3,
  ),
];

List<Panier> listDuPanier = [
  Panier(
    id: 1,
    userId: 1,
    dataModelId: 1
  ),
  Panier(
    id: 2,
    userId: 1,
    dataModelId: 4
  )
];

class PanierPage extends StatefulWidget {
  const PanierPage({Key? key}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  @override
  Widget build(BuildContext context) {
    // Calculer le prix total des articles dans le panier
    double prixTotal = 0;
    listDuPanier.forEach((panierItem) {
      prixTotal += todoList[panierItem.dataModelId - 1].prix;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: ListView.builder(
        itemCount: listDuPanier.length + 1, // +1 pour le prix total
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        itemBuilder: (context, index) {
          // Afficher le prix total à la dernière ligne
          if (index == listDuPanier.length) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color.fromARGB(118, 0, 62, 156),
                borderRadius: BorderRadius.circular(40),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: 'Prix Total : ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 62, 156)
                      ),
                    ),
                    TextSpan(
                      text: '$prixTotal €',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color.fromARGB(255, 0, 62, 156)
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // Afficher les éléments du panier
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
                      todoList[listDuPanier[index].dataModelId - 1].image,
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
                            todoList[listDuPanier[index].dataModelId - 1].titre,
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
                                  text: '${todoList[listDuPanier[index].dataModelId - 1].lieu}',
                                ),
                                TextSpan(
                                  text: '  Prix : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '${todoList[listDuPanier[index].dataModelId - 1].prix} €',
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
                        deleteToPanier(listDuPanier[index].dataModelId);
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
      ),
    );
  }

  void deleteToPanier(int dataModelId) {
    // Supprimer l'élément avec le dataModelId et userId 1 de la listeDuPanier
    setState(() {
      listDuPanier.removeWhere((item) => item.userId == 1 && item.dataModelId == dataModelId);
    });
  }
}
