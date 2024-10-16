// lib/screens/create_pet_screen.dart

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/section.dart';
import '../widgets/create_pet_form.dart';
import '../constants/colors.dart';
import '../constants/config.dart';
import '../data/pet_breed_data.dart';

class CreatePetScreen extends StatefulWidget {
  const CreatePetScreen({super.key});

  @override
  _CreatePetScreenState createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  int? gender;
  String? breed;
  String? birthDate;
  XFile? image;

  late List<String> _breedList;

  @override
  void initState() {
    super.initState();
    _breedList = List.from(breedList);
  }

  Future<void> _createPet() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (name == null ||
          gender == null ||
          breed == null ||
          birthDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('모든 필드를 입력해주세요.')),
        );
        return;
      }

      try {
        var request = http.MultipartRequest(
            'POST', Uri.parse('${Config.getServerURL()}/pet'));
        request.fields['name'] = name!;
        request.fields['gender'] = gender!.toString();
        request.fields['breed'] = breed!;
        request.fields['birth'] = birthDate!;

        if (image != null) {
          request.files
              .add(await http.MultipartFile.fromPath('image', image!.path));
        }

        var response = await request.send();
        if (response.statusCode == 200) {
          Navigator.pop(context);
        } else {
          throw Exception('Failed to create pet');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('펫 생성 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새 펫 등록')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '등록을 위해 아이의 정보를 입력해주세요!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    PetImage(
                      onFileChange: (XFile file) {
                        setState(() {
                          image = file;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PetProfileForm(
                        onNameChange: (String value) {
                          setState(() {
                            name = value;
                          });
                        },
                        onGenderChange: (int value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Section(
                  title: '생년월일',
                  child: BirthDay(
                    onChangeDate: (String? date) {
                      setState(() {
                        birthDate = date;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Section(
                  title: '품종',
                  child: DropdownButtonFormField<String>(
                    value: breed,
                    items: _breedList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        breed = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '품종을 선택해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ORANGE,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _createPet,
                  child: Text('추가'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// BirthDay widget from create_pet_form.dart
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
