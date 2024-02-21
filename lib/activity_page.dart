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

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // Liste pour suivre l'état d'expansion pour chaque tuile
  List<bool> isExpanded = List.generate(todoList.length, (index) => false);

  List<Panier> panier = []; // Liste du panier

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      itemBuilder: (context, index) => Padding(
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
                  todoList[index].image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                bottom: isExpanded[index] ? -100 : 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded[index] = !isExpanded[index];
                    });
                  },
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
                          todoList[index].titre,
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
                                text: '${todoList[index].lieu}',
                              ),
                              TextSpan(
                                text: '  Prix : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${todoList[index].prix} €',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 48,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded[index] = !isExpanded[index];
                    });
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
                    // Ajouter l'élément au panier
                    insertToPanier(todoList[index].id);
                  },
                  icon: Icon(
                    panier.any((item) =>
                            item.userId == 1 &&
                            item.dataModelId == todoList[index].id)
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                  ),
                  color: 
                    panier.any((item) =>
                            item.userId == 1 &&
                            item.dataModelId == todoList[index].id)
                        ? Colors.green // Si l'élément est dans le panier, couleur verte
                        : Colors.white, // Sinon, couleur blanche
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertToPanier(int dataModelId) {
    // Vérifier si l'élément est déjà dans le panier pour cet utilisateur
    bool isAlreadyInCart = panier.any((item) =>
        item.userId == 1 && item.dataModelId == dataModelId);

    if (!isAlreadyInCart) {
      // Si l'élément n'est pas déjà dans le panier, l'ajouter
      setState(() {
        panier.add(
          Panier(
            id: panier.length + 1, // ID du panier peut être géré différemment
            userId: 1, // ID de l'utilisateur
            dataModelId: dataModelId, // ID du DataModel sélectionné
          ),
        );
      });
    }

    print("Contenu du panier :");
    panier.forEach((item) {
      print("ID: ${item.id}, UserID: ${item.userId}, DataModelID: ${item.dataModelId}");
    });
    print("Fin du panier.");
  }
}
