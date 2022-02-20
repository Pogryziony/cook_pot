import 'package:cook_pot/bloc/authentication_bloc.dart';
import 'package:cook_pot/core/settings/settings_screen.dart';
import 'package:cook_pot/modules/recipes/bloc/recipes_bloc.dart';
import 'package:cook_pot/modules/recipes/appetizers/recipes_screen.dart';
import 'package:cook_pot/widgets/card/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {
  static var routeName = '/mainMenu';

  void logoutButtonPressed(BuildContext context, {bool listen = true}) {
    Provider.of<AuthenticationBloc>(context, listen: false).add(LoggedOut());
  }

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
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return BlocProvider.value(
                  value: BlocProvider.of<RecipesBloc>(context)
                    ..add(LoadRecipesEvent())
                    ..category = 'appetizer',
                  child: RecipesScreen(),
                );
              })),
            ),
            CategoryCard(
              categoryName: 'Main dishes',
              assetPath: 'assets/images/main_dish.png',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return BlocProvider.value(
                  value: BlocProvider.of<RecipesBloc>(context)
                    ..add(LoadRecipesEvent())
                    ..category = 'main_dish',
                  child: RecipesScreen(),
                );
              })),
            ),
            CategoryCard(
              categoryName: 'Desserts',
              assetPath: 'assets/images/dessert.png',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return BlocProvider.value(
                  value: BlocProvider.of<RecipesBloc>(context)
                    ..add(LoadRecipesEvent())
                    ..category = 'dessert',
                  child: RecipesScreen(),
                );
              })),
            ),
            CategoryCard(
              categoryName: 'Drinks',
              assetPath: 'assets/images/drink.png',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return BlocProvider.value(
                  value: BlocProvider.of<RecipesBloc>(context)
                    ..add(LoadRecipesEvent())
                    ..category = 'drink',
                  child: RecipesScreen(),
                );
              })),
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
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return SettingsScreen();
                    }),
                  )
                },
              ),
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AuthenticationRevoked) {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (_) => false);
                    });
                  }
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () => {logoutButtonPressed(context)},
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
