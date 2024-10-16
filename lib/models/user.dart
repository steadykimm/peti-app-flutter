// lib/models/user.dart

class User {
  final int identify;
  final String name;
  final String email;
  final String phone;

  User({
    required this.identify,
    required this.name,
    required this.email,
    required this.phone,
  });

  // JSON 직렬화를 위한 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      identify: json['identify'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  // JSON 직렬화를 위한 메서드
  Map<String, dynamic> toJson() {
    return {
      'identify': identify,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  // toString 메서드 오버라이드
  @override
  String toString() {
    return 'User(identify: $identify, name: $name, email: $email, phone: $phone)';
  }
}
