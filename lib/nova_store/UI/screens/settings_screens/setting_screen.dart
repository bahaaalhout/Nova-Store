import 'package:flutter/material.dart';
import 'package:nova_store/nova_routes.dart';
import 'package:nova_store/nova_store/Data/auth_firebase.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home Screen'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favorite Screen'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/favorite');
          },
        ),

        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Cart Screen'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/cart');
          },
        ),

        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/settings');
          },
        ),

        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log Out'),
          onTap: () {
            Navigator.pop(context);
            AuthFirebase.signOut();
            Navigator.of(context).pushReplacementNamed(NovaRoutes.login);
          },
        ),
      ],
    );
  }
}
