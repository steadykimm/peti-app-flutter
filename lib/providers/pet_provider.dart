import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/pet.dart';
import '../constants/config.dart';
import '../data/pet_list_data.dart';

class PetProvider extends ChangeNotifier {
  List<Pet> _pets = [];
  List<Pet> get pets => _pets;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPets() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 1));
      _pets = petListTestData;
      // 여기까지 임시 데이터 적용 로직

      // final response =
      //     await http.get(Uri.parse('${Config.getServerURL()}/pet'));
      // if (response.statusCode == 200) {
      //   final result = json.decode(response.body);
      //   (result['list'] as List).map((item) => Pet.fromJson(item)).toList();
      // } else {
      //   throw Exception('Failed to fetch pets: ${response.reasonPhrase}');
      // }
    } catch (error) {
      print('Error fetching pets: $error');
      // You might want to set an error state here
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void refetch() {
    fetchPets();
  }
}
