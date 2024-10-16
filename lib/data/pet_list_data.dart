import '../models/pet.dart';

final List<Pet> petListTestData = [
  Pet(
    birthdate: "2020-12-23",
    petId: 0,
    name: "맥스",
    gender: PetGender.male,
    breed: "골든 리트리버",
    birth: "2020-12-23",
    profilePictureURL: null,
  ),
  Pet(
    birthdate: "2021-05-15",
    petId: 1,
    name: "벨라",
    gender: PetGender.female,
    breed: "래브라도 리트리버",
    birth: "2021-05-15",
    profilePictureURL: null,
  ),
  Pet(
    birthdate: "2022-03-10",
    petId: 2,
    name: "찰리",
    gender: PetGender.male,
    breed: "비글",
    birth: "2022-03-10",
    profilePictureURL: null,
  ),
  Pet(
    birthdate: "2019-09-01",
    petId: 3,
    name: "루시",
    gender: PetGender.female,
    breed: "포메라니안",
    birth: "2019-09-01",
    profilePictureURL: null,
  ),
  Pet(
    birthdate: "2020-11-11",
    petId: 4,
    name: "코코",
    gender: PetGender.male,
    breed: "시바 이누",
    birth: "2020-11-11",
    profilePictureURL: null,
  ),
];

// VitalData 테스트 데이터
final Map<int, VitalData> dogVitalDataTestData = {
  0: VitalData(bpm: 95, temperature: 38.3), // 골든 리트리버
  1: VitalData(bpm: 100, temperature: 38.5), // 래브라도 리트리버
  2: VitalData(bpm: 110, temperature: 38.7), // 비글
  3: VitalData(bpm: 120, temperature: 38.6), // 포메라니안
  4: VitalData(bpm: 105, temperature: 38.4), // 시바 이누
};
