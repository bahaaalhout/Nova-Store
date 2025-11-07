import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Data/sqlite_db.dart';
import 'package:nova_store/nova_store/UI/provider/auth_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/cart_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/product_cubit.dart';
import 'package:nova_store/nova_store/UI/screens/auth_screens/login_screen.dart';
import 'package:nova_store/nova_store/UI/screens/auth_screens/signup_screen.dart';
import 'package:nova_store/nova_store/UI/screens/main_screen.dart';
import 'package:nova_store/bloc_observer.dart';
import 'package:nova_store/firebase_options.dart';
import 'package:nova_store/nova_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ProductSqliteDb.init();
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit()..fetchData(),
        ),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        BlocProvider<FavoriteCubit>(
          create: (context) => FavoriteCubit()..initProduct(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var nextScreen = BlocProvider.of<AuthCubit>(context).isLoggedIn();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nova Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.grey, size: 24),
      ),
      routes: {
        NovaRoutes.home: (context) => MainScreen(),
        NovaRoutes.login: (context) => LoginScreen(),
        NovaRoutes.signup: (context) => SignupScreen(),
        NovaRoutes.cart: (context) => MainScreen(selectedIndex: 2),
        NovaRoutes.favorite: (context) => MainScreen(selectedIndex: 1),

        NovaRoutes.settings: (context) => MainScreen(selectedIndex: 3),
      },
      home: AnimatedSplashScreen(
        splash: 'assets/logo.png',
        splashIconSize: 350,
        nextScreen: nextScreen ? MainScreen() : LoginScreen(),

        animationDuration: Duration(milliseconds: 700),
      ),
    );
  }
}
