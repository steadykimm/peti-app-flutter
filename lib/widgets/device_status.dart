import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DeviceStatus extends StatelessWidget {
  final String petName;
  final String batteryStatus;
  final String petId;

  const DeviceStatus({
    super.key,
    required this.petName,
    required this.batteryStatus,
    required this.petId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 $petName',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Image.asset(
          // 'assets/images/$batteryStatus',
          'assets/images/batteryState02.png',
          width: 36,
          height: 36,
        ),
      ],
    );
  }
}
