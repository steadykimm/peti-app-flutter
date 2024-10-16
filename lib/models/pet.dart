/// 펫의 성별을 나타내는 열거형
/// 0: 수컷, 1: 암컷, 2: 중성
enum PetGender { male, female, neutral }

/// 기본 펫 정보를 나타내는 클래스
class Pet {
  final String birthdate;
  final int petId;
  final String name;
  final PetGender gender;
  final String breed;
  final String birth;
  final String? profilePictureURL;

  Pet({
    required this.birthdate,
    required this.petId,
    required this.name,
    required this.gender,
    required this.breed,
    required this.birth,
    this.profilePictureURL,
  });

  // JSON 직렬화를 위한 팩토리 생성자
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      birthdate: json['birthdate'],
      petId: json['petId'],
      name: json['name'],
      gender: PetGender.values[json['gender']],
      breed: json['breed'],
      birth: json['birth'],
      profilePictureURL: json['profilePictureURL'],
    );
  }

  // JSON 직렬화를 위한 메서드
  Map<String, dynamic> toJson() {
    return {
      'birthdate': birthdate,
      'petId': petId,
      'name': name,
      'gender': gender.index,
      'breed': breed,
      'birth': birth,
      'profilePictureURL': profilePictureURL,
    };
  }
}

/// 상세 펫 정보를 나타내는 클래스
class PetDetail extends Pet {
  final String createdAt;
  final String updatedAt;

  PetDetail({
    required super.birthdate,
    required super.petId,
    required super.name,
    required super.gender,
    required super.breed,
    required super.birth,
    required super.profilePictureURL,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON 직렬화를 위한 팩토리 생성자
  factory PetDetail.fromJson(Map<String, dynamic> json) {
    return PetDetail(
      birthdate: json['birthdate'],
      petId: json['petId'],
      name: json['name'],
      gender: PetGender.values[json['gender']],
      breed: json['breed'],
      birth: json['birth'],
      profilePictureURL: json['profilePictureURL'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // JSON 직렬화를 위한 메서드
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

/// 생체 데이터를 나타내는 클래스
class VitalData {
  final int bpm;
  final double temperature;

  VitalData({
    required this.bpm,
    required this.temperature,
  });

  // JSON 직렬화를 위한 팩토리 생성자
  factory VitalData.fromJson(Map<String, dynamic> json) {
    return VitalData(
      bpm: json['bpm'],
      temperature: json['temperature'].toDouble(),
    );
  }

  // JSON 직렬화를 위한 메서드
  Map<String, dynamic> toJson() {
    return {
      'bpm': bpm,
      'temperature': temperature,
    };
  }
}
