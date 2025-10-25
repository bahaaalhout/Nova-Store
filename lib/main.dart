import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_shop/Nova%20Shop/UI/provider/auth_cubit.dart';
import 'package:nova_shop/Nova%20Shop/UI/screens/home_screen.dart';
import 'package:nova_shop/Nova%20Shop/UI/screens/auth_screens/login_screen.dart';
import 'package:nova_shop/Nova%20Shop/UI/screens/auth_screens/signup_screen.dart';
import 'package:nova_shop/bloc_observer.dart';
import 'package:nova_shop/firebase_options.dart';
import 'package:nova_shop/nova_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  runApp(
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
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
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.grey)),
        iconTheme: const IconThemeData(color: Colors.grey, size: 24),
      ),
      routes: {
        NovaRoutes.main: (context) => MyApp(),
        NovaRoutes.home: (context) => HomeScreen(),
        NovaRoutes.login: (context) => LoginScreen(),
        NovaRoutes.signup: (context) => SignupScreen(),
      },
      home: AnimatedSplashScreen(
        splash: 'assets/images/logo.png',
        splashIconSize: 350,
        nextScreen: nextScreen ? HomeScreen() : LoginScreen(),
        animationDuration: Duration(milliseconds: 700),
      ),
    );
  }
}
