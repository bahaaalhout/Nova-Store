import 'package:flutter/material.dart';
import 'package:nova_store/nova_store/Data/auth_firebase.dart';
import 'package:nova_store/nova_routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsetsGeometry.all(0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xFFFF3D00), // Bright Red
                    Color(0xFFFF6D00), // Orange
                    Color(0xFFFF4081), // Pink Accent
                    Color(0xFF9C27B0), // Deep Purple
                  ],
                ),
              ),
              child: Text(
                'NOVA Store',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),

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
      ),
    );
  }
}
