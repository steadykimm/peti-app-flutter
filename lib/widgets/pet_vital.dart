// lib/widgets/pet_vital.dart

import 'package:flutter/material.dart';

class PetVital extends StatelessWidget {
  final num bpm;
  final num temperature;

  const PetVital({
    super.key,
    required this.bpm,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/heartbeat-icon.png',
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              const SizedBox(width: 10),
              Text('$bpm bpm',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/images/temperature-icon.png',
                  width: 30, height: 30),
              const SizedBox(width: 5),
              Text('${temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEA5A2D))),
            ],
          ),
        ],
      ),
    );
  }
}
