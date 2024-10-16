// lib/screens/user_menu_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserMenuScreen extends StatelessWidget {
  const UserMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              user?.name ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildImageButton('assets/images/userinfo-btn.png', 105),
            const SizedBox(height: 10),
            _buildImageButton('assets/images/peteye-btn.png', 120),
            const SizedBox(height: 40),
            const Text(
              '서비스 전체',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            _buildServiceItem('assets/images/calendar-icon.png', '일정'),
            _buildServiceItem('assets/images/piechart-icon.png', '활동보고서'),
            _buildServiceItem('assets/images/settings-icon.png', '환경설정'),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(String imagePath, double height) {
    return InkWell(
      onTap: () {
        // 버튼 동작 구현
      },
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildServiceItem(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          // 서비스 항목 동작 구현
        },
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
