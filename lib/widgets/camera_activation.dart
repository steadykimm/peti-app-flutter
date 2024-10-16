import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CameraActivationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CameraActivationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ORANGE,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/camera-icon.png',
            width: 28,
            height: 28,
            color: Colors.white,
          ),
          const SizedBox(width: 14),
          const Text('PET - EYE',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
