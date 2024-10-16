// lib/routes/app_routes.dart

import 'package:flutter/material.dart';
import '../screens/developer_screen.dart';
import '../screens/pet_page_screen.dart';
import '../screens/user_menu_screen.dart';
import '../screens/login_screen.dart';
import '../screens/pet_list_screen.dart';
import '../screens/create_pet_screen.dart';
import '../screens/edit_pet_list_screen.dart';
import '../screens/signin_screen.dart';
import '../widgets/auth_wrapper.dart';
import '../models/pet.dart';

class AppRoutes {
  static const String developer = '/developer';
  static const String petPage = '/pet_page';
  static const String userMenu = '/user_menu';
  static const String login = '/login';
  static const String petList = '/pet_list';
  static const String createPet = '/create_pet';
  static const String editPetList = '/edit_pet_list';
  static const String signin = '/signin';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case developer:
        return MaterialPageRoute(builder: (_) => const DeveloperScreen());
      case petPage:
        final pet = settings.arguments as Pet?;
        return MaterialPageRoute(builder: (_) => PetPageScreen(pet: pet));
      case userMenu:
        return MaterialPageRoute(
            builder: (_) => const AuthWrapper(child: UserMenuScreen()));
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case petList:
        return MaterialPageRoute(
            // builder: (_) => const AuthWrapper(child: PetListScreen()));
            builder: (_) => const PetListScreen());
      case createPet:
        return MaterialPageRoute(builder: (_) => const CreatePetScreen());
      case editPetList:
        return MaterialPageRoute(builder: (_) => const EditPetListScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/images/backbtn.png', width: 30, height: 30),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.developer,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
            leading: child?.toString() != '/' ? const CustomBackButton() : null,
          ),
          body: child,
        );
      },
    );
  }
}
