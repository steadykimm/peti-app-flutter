import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../providers/user_provider.dart';
import '../utils/network_utils.dart';
import '../models/user.dart';

class AuthWrapper extends StatefulWidget {
  final Widget child;

  const AuthWrapper({super.key, required this.child});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUser();
    });
  }

  Future<void> _fetchUser() async {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user != null) return;

    try {
      final response =
          await http.post(Uri.parse('${NetworkUtils.getHost()}/auth'));
      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        userProvider.setUser(User.fromJson(result['user']));
      } else {
        throw Exception(result['message'] ?? '로그인이 필요한 페이지입니다.');
      }
    } catch (error) {
      // userProvider.alert(
      //   context,
      //   '오류',
      //   error.toString(),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
