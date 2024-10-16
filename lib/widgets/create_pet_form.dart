import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../constants/colors.dart';

class BirthDay extends StatefulWidget {
  final Function(String?) onChangeDate;

  const BirthDay({super.key, required this.onChangeDate});

  @override
  _BirthDayState createState() => _BirthDayState();
}

class _BirthDayState extends State<BirthDay> {
  String? year, month, day;

  void updateDate() {
    if (year != null && month != null && day != null) {
      widget.onChangeDate('$year-$month-$day');
    } else {
      widget.onChangeDate(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDateInput(
            'YYYY',
            4,
            (value) => setState(() {
                  year = value;
                  updateDate();
                })),
        const Text(':',
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900)),
        _buildDateInput(
            'MM',
            2,
            (value) => setState(() {
                  month = value;
                  updateDate();
                })),
        const Text(':',
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900)),
        _buildDateInput(
            'DD',
            2,
            (value) => setState(() {
                  day = value;
                  updateDate();
                })),
      ],
    );
  }

  Widget _buildDateInput(
      String placeholder, int maxLength, Function(String) onChanged) {
    return SizedBox(
      width: placeholder == 'YYYY' ? 120 : 80,
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        style: const TextStyle(
            fontSize: 42, fontWeight: FontWeight.w900, color: Colors.black),
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        onChanged: onChanged,
      ),
    );
  }
}

class PetProfileForm extends StatefulWidget {
  final Function(String) onNameChange;
  final Function(int) onGenderChange;

  const PetProfileForm(
      {super.key, required this.onNameChange, required this.onGenderChange});

  @override
  _PetProfileFormState createState() => _PetProfileFormState();
}

class _PetProfileFormState extends State<PetProfileForm> {
  int? gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: '이름을 입력하여주세요',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.ORANGE, width: 2),
              ),
            ),
            onChanged: widget.onNameChange,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGenderButton(0, 'assets/images/man.png'),
              _buildGenderButton(1, 'assets/images/female.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderButton(int genderValue, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = genderValue;
          widget.onGenderChange(genderValue);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: gender == genderValue ? AppColors.BASIC : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          imagePath,
          width: 60,
          height: 60,
        ),
      ),
    );
  }
}

class PetImage extends StatefulWidget {
  final Function(XFile) onFileChange;

  const PetImage({super.key, required this.onFileChange});

  @override
  _PetImageState createState() => _PetImageState();
}

class _PetImageState extends State<PetImage> {
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      widget.onFileChange(_image! as XFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: _image != null
                    ? FileImage(_image!)
                    : const AssetImage('assets/images/default-profile.png')
                        as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.ORANGE,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _pickImage,
            child: Text('프로필 사진 업로드'),
          ),
        ],
      ),
    );
  }
}

// 전체 폼을 조합하는 위젯
class CreatePetForm extends StatelessWidget {
  const CreatePetForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PetImage(onFileChange: (file) {
              // Handle file change
            }),
            PetProfileForm(
              onNameChange: (name) {
                // Handle name change
              },
              onGenderChange: (gender) {
                // Handle gender change
              },
            ),
          ],
        ),
        BirthDay(onChangeDate: (date) {
          // Handle date change
        }),
        // Add other form fields as needed
      ],
    );
  }
}
