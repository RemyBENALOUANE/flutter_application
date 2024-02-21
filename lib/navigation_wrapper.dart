import 'package:flutter/material.dart';
import 'activity_page.dart';
import 'panier_page.dart';
import 'profil_page.dart';

class NavigationWrapper extends StatefulWidget {

  final String userId; // Ajoutez un champ pour l'ID de l'utilisateur

  NavigationWrapper({Key? key, required this.userId}) : super(key: key);

  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[]; // Supprimez static

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      ActivityPage(userId: widget.userId), // Utilisez widget.userId ici
      PanierPage(),
      ProfilPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Activités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 62, 156),
        onTap: _onItemTapped,
      ),
    );
  }
}
