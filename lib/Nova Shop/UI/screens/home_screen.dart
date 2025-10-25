import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),

      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/grid.png', width: 20),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text(
          'NOVA Store',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.grey.shade600,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
