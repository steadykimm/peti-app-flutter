// lib/screens/pet_page_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/pet.dart';
import '../widgets/device_status.dart';
import '../widgets/pet_profile.dart';
import '../widgets/pet_vital.dart';
import '../widgets/vital_graph.dart';
import '../utils/date_utils.dart';
import '../constants/colors.dart';
import '../data/mock_data.dart';
import '../widgets/find_device.dart';
import '../widgets/camera_activation.dart';

class PetPageScreen extends StatelessWidget {
  final Pet pet;

  // const PetPageScreen({super.key, required this.pet});
  PetPageScreen({super.key, Pet? pet}) : pet = pet ?? mockPet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/backbtn.png',
            width: 24,
            height: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DeviceStatus(
                    petName: pet.name,
                    batteryStatus: 'batteryState02.png',
                    petId: pet.petId.toString(),
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      PetProfile(
                        profilePictureUrl: pet.profilePictureURL,
                        petName: pet.name,
                        gender: pet.gender,
                        breed: pet.breed,
                        birthdate: pet.birth,
                      ),
                      Positioned(
                        top: 20,
                        left: 16,
                        child: Image.asset(
                          'assets/images/movementstate-run.png',
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  const PetVital(
                    bpm: 110,
                    temperature: 37.0,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(height: 5),
                  // FindDeviceButton(),
                  const SizedBox(height: 5),
                  CameraActivationButton(onPressed: () {})
                ],
              ),
            ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 60,
      color: AppColors.ORANGE,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/alert-icon.png',
            width: 32,
            height: 32,
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/petiLogoW.png',
            width: 32,
            height: 32,
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/menuIcon.png',
            width: 32,
            height: 32,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
