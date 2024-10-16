// lib/widgets/pet_list.dart

import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../utils/date_utils.dart';
import '../constants/colors.dart';

class PetList extends StatelessWidget {
  final List<Pet> pets;
  final Function(Pet) onItemPress;

  const PetList({
    super.key,
    required this.pets,
    required this.onItemPress,
  });

  @override
  Widget build(BuildContext context) {
    print('Number of pets: ${pets.length}');
    pets.forEach((pet) => print('Pet: ${pet.name}, Birth: ${pet.birth}'));

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        return PetItem(
          pet: pets[index],
          profileImageUrl: pets[index].profilePictureURL,
          onPress: () => onItemPress(pets[index]),
        );
      },
    );
  }
}

class PetItem extends StatelessWidget {
  final Pet pet;
  final String? profileImageUrl;
  final VoidCallback onPress;

  const PetItem({
    super.key,
    required this.pet,
    this.profileImageUrl,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.BASIC,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: profileImageUrl != null
                  ? NetworkImage(
                      'http://192.168.217.1:5500/img/$profileImageUrl')
                  : const AssetImage('assets/images/default-profile.png')
                      as ImageProvider,
            ),
            Column(
              children: [
                Text(
                  pet.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
                Text(
                  getDateString(DateTime.parse(pet.birth)),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
