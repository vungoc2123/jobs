import 'package:json_annotation/json_annotation.dart';
part 'experience.g.dart';
@JsonSerializable()
class Experience {
  String company;
  String imageCompany;
  String position;
  String address;
  String experience;

  Experience(
      {required this.company,
        required this.imageCompany,
        required this.position,
        required this.address,
        required this.experience});

  factory Experience.fromJson(Map<String,dynamic> json) => _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}