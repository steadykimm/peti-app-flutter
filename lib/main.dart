// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'providers/user_provider.dart';
import 'providers/pet_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PetProvider()),
      ],
      child: MaterialApp(
        title: 'Your App Name',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SafeArea(
          child: AppNavigator(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Navigator(
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.petPage,
    );
  }
}
