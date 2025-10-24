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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   isLoggedIn();
  // }

  @override
  Widget build(BuildContext context) {
    var nextScreen = BlocProvider.of<AuthCubit>(context).isLoggedIn();
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nova Shop',
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
      ),
    );
  }

  // isLoggedIn() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   BlocProvider.of<AuthCubit>(context).isLoggedIn();
  // }
}
