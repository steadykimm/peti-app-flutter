// lib/screens/edit_pet_list_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../widgets/edit_pet_list.dart';
import '../models/pet.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import '../constants/config.dart';
import '../providers/user_provider.dart';
import '../providers/pet_provider.dart';

class EditPetListScreen extends StatefulWidget {
  const EditPetListScreen({super.key});

  @override
  _EditPetListScreenState createState() => _EditPetListScreenState();
}

class _EditPetListScreenState extends State<EditPetListScreen> {
  List<int> deletedPetIds = [];

  void handleDelete(int petId) {
    setState(() {
      deletedPetIds.add(petId);
    });
  }

  Future<void> handleSave() async {
    try {
      final response = await http.post(
        Uri.parse('${Config.getServerURL()}/pet/edit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'petIds': deletedPetIds}),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(result['message']);
      }

      setState(() {
        deletedPetIds.clear();
      });

      context.read<PetProvider>().fetchPets();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수정이 완료되었습니다.')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('수정 실패: ${error.toString()}')),
      );
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final pets = context.watch<PetProvider>().pets;
    final filteredPets =
        pets.where((pet) => !deletedPetIds.contains(pet.petId)).toList();

    return Scaffold(
      backgroundColor: AppColors.BASIC,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Styles.MARGIN),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${user?.name ?? ''} 님의 아이들',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: EditPetList(
                  pets: filteredPets,
                  onDelete: handleDelete,
                  deletedPets: deletedPetIds,
                  onAddNew: () {},
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.DEEP_ORANGE,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: handleSave,
                child: Text('수정완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
