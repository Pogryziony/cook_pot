import 'package:cook_pot/core/auth/login/login_screen.dart';
import 'package:cook_pot/widgets/card/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cook pot'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            CategoryCard(
              categoryName: 'Appetizers',
              assetPath: 'assets/images/appetizer.png',
              onPressed: () => {},
            ),
            CategoryCard(
              categoryName: 'Main dishes',
              assetPath: 'assets/images/main_dish.png',
              onPressed: () => {},
            ),
            CategoryCard(
              categoryName: 'Desserts',
              assetPath: 'assets/images/dessert.png',
              onPressed: () => {},
            ),
            CategoryCard(
              categoryName: 'Drinks',
              assetPath: 'assets/images/drink.png',
              onPressed: () => {},
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('My profile'),
                onTap: () => {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.article),
                title: Text('My recipes'),
                onTap: () => {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.favorite),
                title: const Text('Favourites'),
                onTap: () => {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.app_settings_alt_rounded),
                title: const Text('Settings'),
                onTap: () => {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()))
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
