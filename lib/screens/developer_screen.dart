// lib/screens/developer_screen.dart

import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Developer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationButton(context, 'UserMenu', '/user_menu'),
            _buildNavigationButton(context, 'Login', '/login'),
            _buildNavigationButton(context, 'Pet', '/pet_page'),
            // _buildNavigationButton(context, 'Pet', '/pet_page', arguments: Pet(...)),
            _buildNavigationButton(context, 'PetList', '/pet_list'),
            _buildNavigationButton(context, 'CreatePet', '/create_pet'),
            _buildNavigationButton(context, 'EditPetList', '/edit_pet_list'),
            _buildNavigationButton(context, 'Signin', '/signin'),
            ElevatedButton(
              child: const Text('Alert !'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('알림 메시지 창입니다.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String title, String route,
      {Object? arguments}) {
    return ElevatedButton(
      child: Text(title),
      onPressed: () =>
          Navigator.pushNamed(context, route, arguments: arguments),
    );
  }
}
