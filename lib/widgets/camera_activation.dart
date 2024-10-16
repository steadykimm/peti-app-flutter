import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CameraActivationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CameraActivationButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ORANGE,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/camera-icon.png',
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text('PET-EYE', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
