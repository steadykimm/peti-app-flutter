// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/config.dart';
import '../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? inputEmail;
  String? inputPassword;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _loadRememberMe();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final response =
          await http.get(Uri.parse('${Config.getServerURL()}/auth'));
      final result = json.decode(response.body);
      if (result.containsKey('user')) {
        Navigator.pushReplacementNamed(context, '/pet_list');
      }
    } catch (e) {
      print('Error checking login status: $e');
    }
  }

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        inputEmail = prefs.getString('inputEmail');
      }
    });
  }

  Future<void> _loginRequest(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Config.getServerURL()}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final result = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(result['message']);
      }

      _showAlert('로그인 성공', '${result['user']['username']}님 반갑습니다.', () {
        Navigator.pushReplacementNamed(context, '/pet_list');
      });

      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('rememberMe', rememberMe);
        await prefs.setString('inputEmail', email);
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('rememberMe');
        await prefs.remove('inputEmail');
      }
    } catch (error) {
      _showAlert('로그인 실패', error.toString(), null);
    }
  }

  void _showAlert(String title, String message, VoidCallback? onOk) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              if (onOk != null) onOk();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 배경 이미지
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // 어두운 오버레이
          Container(
            color: Colors.black.withOpacity(0.5), // 명도를 낮추기 위한 반투명 검은색 오버레이
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Image.asset('assets/images/peti-text-icon-w.png', height: 60),
                  const Spacer(flex: 2),
                  _buildTextField(
                      'ID', '이메일 주소를 입력해주세요', (value) => inputEmail = value),
                  const SizedBox(height: 20),
                  _buildTextField(
                      'PW', '비밀번호를 입력해주세요', (value) => inputPassword = value,
                      isPassword: true),
                  const SizedBox(height: 10),
                  _buildRememberMeCheckbox(),
                  const SizedBox(height: 30),
                  _buildLoginButton(),
                  const SizedBox(height: 20),
                  _buildSignUpButton(),
                  const Spacer(flex: 3),
                  _buildForgotPasswordButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, Function(String) onChanged,
      {bool isPassword = false}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (bool? value) async {
            setState(() => rememberMe = value ?? false);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('rememberMe', rememberMe);
          },
          activeColor: const Color(0xFFEA5A2D),
          checkColor: Colors.grey,
        ),
        const Text('로그인 정보 저장', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (inputEmail == null || inputEmail!.isEmpty) {
          _showAlert('경고', '이메일을 입력해주세요', null);
          return;
        }
        if (inputPassword == null || inputPassword!.isEmpty) {
          _showAlert('경고', '비밀번호를 입력해주세요', null);
          return;
        }
        _loginRequest(inputEmail!, inputPassword!);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEA5A2D),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: const Text('로그인',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/signin'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: const Text('이메일로 회원가입',
          style: TextStyle(
              color: Color(0xFFEA5A2D),
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      child: const Text('ID / 비밀번호 찾기 >',
          style: TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)),
      onPressed: () {
        // Implement ID/PW recovery logic
      },
    );
  }
}
