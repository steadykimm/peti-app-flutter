import 'package:flutter/material.dart';
import 'package:peti_app/models/pet.dart';
import 'package:peti_app/constants/colors.dart';

class PetProfile extends StatelessWidget {
  final String? profilePictureUrl;
  final String petName;
  final PetGender gender;
  final String breed;
  final String birthdate;

  const PetProfile({
    super.key,
    this.profilePictureUrl,
    required this.petName,
    required this.gender,
    required this.breed,
    required this.birthdate,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: 60),
          padding: EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0E5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    petName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    gender == PetGender.male
                        ? 'assets/images/man.png'
                        : 'assets/images/female.png',
                    width: 15,
                    height: 15,
                  ),
                ],
              ),
              Text(birthdate,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Text(breed,
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: profilePictureUrl != null
                  ? NetworkImage(
                      'http://192.168.217.1:5500/img/$profilePictureUrl')
                  : const AssetImage('assets/images/default-profile.png')
                      as ImageProvider,
            ),
          ),
        ),
        Positioned(
          top: 70,
          right: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/edit_pet_list_screen');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.ORANGE,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '편집',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
