// lib/widgets/pet_widgets.dart

import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DeviceStatus extends StatelessWidget {
  final String batteryStatus;
  final String petId;
  final String petName;

  const DeviceStatus({
    super.key,
    required this.batteryStatus,
    required this.petId,
    required this.petName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '오늘의 $petName',
          style: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Image.network(
          'http://192.168.217.1:5500/img/$batteryStatus',
          width: 70,
          height: 35,
        ),
      ],
    );
  }
}

class PetProfile extends StatelessWidget {
  final String petName;
  final int gender;
  final String birthdate;
  final String? profilePictureUrl;
  final String breed;

  const PetProfile({
    super.key,
    required this.petName,
    required this.gender,
    required this.birthdate,
    this.profilePictureUrl,
    required this.breed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.BASIC,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profilePictureUrl != null
                      ? NetworkImage(
                          'http://192.168.217.1:5500/img/$profilePictureUrl')
                      : const AssetImage('assets/images/default-profile.png')
                          as ImageProvider,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      petName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      gender == 0
                          ? 'assets/images/man.png'
                          : 'assets/images/female.png',
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
                Text(
                  '$birthdate\n$breed',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            right: 15,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.DEEP_ORANGE,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '편집',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PetVital extends StatelessWidget {
  final int bpm;
  final double temperature;

  const PetVital({
    super.key,
    required this.bpm,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.BASIC,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/heartbeat-icon.png',
              width: 30, height: 30, color: Colors.black),
          const SizedBox(width: 10),
          Text(
            '$bpm bpm',
            style: const TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 40),
          Image.asset('assets/images/temperature-icon.png',
              width: 30, height: 30),
          const SizedBox(width: 5),
          Text(
            '${temperature.toStringAsFixed(1)}°C',
            style: const TextStyle(
                color: AppColors.DEEP_ORANGE,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class VitalGraph extends StatelessWidget {
  const VitalGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.BASIC,
        borderRadius: BorderRadius.circular(10),
      ),
      // TODO: Implement graph here
    );
  }
}
