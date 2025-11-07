import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/UI/provider/cart_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/cart_state.dart';

import 'package:nova_store/nova_store/UI/screens/cart_screen/cart_screen.dart';
import 'package:nova_store/nova_store/UI/screens/favorite_screens/favorite_screen.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/home_screen.dart';
import 'package:nova_store/nova_store/UI/screens/settings_screens/setting_screen.dart';
import 'package:nova_store/nova_store/UI/widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.selectedIndex});
  final int? selectedIndex;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  late final List<Widget> data;

  @override
  void initState() {
    super.initState();
    index = widget.selectedIndex ?? 0;

    data = [
      const HomeScreen(),
      const FavoriteScreen(),
      CartScreen(),
      const SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CartCubit>(context, listen: false);
    return Scaffold(
      drawer: MyDrawer(),

      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey[100]!,
              blurRadius: 5,
              offset: Offset(0, -0.1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueGrey[800],
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 8.0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),

              label: '',
            ),
            BottomNavigationBarItem(
              icon: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) => Badge.count(
                  count: cubit.cart.length,
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
              activeIcon: Icon(Icons.shopping_cart),

              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),

              label: '',
            ),
          ],
        ),
      ),
      body: data[index],
    );
  }
}
