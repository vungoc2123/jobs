import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/response/experience.dart';
part 'profile.g.dart';

@JsonSerializable()
class ProfileModel {
  String image;
  String name;
  String yearOfBirth;
  String exp;
  String vacancies;
  String career;
  String salary;
  String level;
  double rate;
  String numberPhone;
  String email;
  String address;
  String addressWork;
  String school;
  String experienceWork;
  String specialized;
  List<Experience> experiences;

  ProfileModel(
      {required this.image,
        required this.name,
        required this.yearOfBirth,
        required this.exp,
        required this.vacancies,
        required this.career,
        required this.salary,
        required this.level,
        required this.rate,
        required this.numberPhone,
        required this.email,
        required this.address,
        required this.experienceWork,
        required this.addressWork,
        required this.school,
        required this.specialized,
        required this.experiences});

  factory ProfileModel.fromJson(Map<String,dynamic> json) => _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}