import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pet_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/pet_list.dart';
import '../models/pet.dart';
import '../constants/styles.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch pets when the screen is first loaded
    Future.microtask(
        () => Provider.of<PetProvider>(context, listen: false).fetchPets());
  }

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Styles.MARGIN),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // '${userProvider.user?.name ?? ''} 님의 아이들',
                    'User 님의 아이들',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/edit-icon.png',
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/edit_pet_list'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: petProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : PetList(
                        pets: petProvider.pets,
                        onItemPress: (Pet pet) {
                          Navigator.pushNamed(
                            context,
                            '/pet_page',
                            arguments: pet,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
