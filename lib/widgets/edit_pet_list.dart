// lib/widgets/edit_pet_list.dart

import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../utils/date_utils.dart';
import '../constants/colors.dart';

class EditPetList extends StatelessWidget {
  final List<Pet> pets;
  final List<int> deletedPets;
  final Function(int) onDelete;
  final VoidCallback onAddNew;

  const EditPetList({
    super.key,
    required this.pets,
    required this.deletedPets,
    required this.onDelete,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      itemCount:
          pets.where((pet) => !deletedPets.contains(pet.petId)).length + 1,
      itemBuilder: (context, index) {
        if (index ==
            pets.where((pet) => !deletedPets.contains(pet.petId)).length) {
          return _buildAddNewItem();
        }
        final pet = pets
            .where((pet) => !deletedPets.contains(pet.petId))
            .toList()[index];
        return PetItem(
          pet: pet,
          onDelete: onDelete,
        );
      },
    );
  }

  Widget _buildAddNewItem() {
    return GestureDetector(
      onTap: onAddNew,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Icon(Icons.add, size: 70, color: Colors.grey),
        ),
      ),
    );
  }
}

class PetItem extends StatelessWidget {
  final Pet pet;
  final Function(int) onDelete;

  const PetItem({
    super.key,
    required this.pet,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: pet.profilePictureURL != null
                    ? NetworkImage(
                        'http://192.168.217.1:5500/img/${pet.profilePictureURL}')
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
          Positioned(
            top: -10,
            right: 10,
            child: GestureDetector(
              onTap: () => onDelete(pet.petId),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
