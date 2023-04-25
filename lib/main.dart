import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/constants/routes.dart';
import 'package:flutter_sample/features/authentication/login/login_screen.dart';
import 'package:flutter_sample/features/home/home_screen.dart';
import 'package:bloc/bloc.dart';
import 'core/states/app_bloc_observer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent));
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: homeScreen,
      routes: {
        loginScreen: (context) => const LoginScreen(),
        homeScreen: (context) => const Homepage()
      },
    );
  }
}
