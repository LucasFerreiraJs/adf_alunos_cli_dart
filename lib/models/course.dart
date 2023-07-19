import 'dart:convert';

class Course {
  late int id;
  late String name;
  late bool isStudent;

  Course({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      name: map['name'],
      isStudent: map['isStudent'],
    );
  }

  factory Course.fromJson(String json) => Course.fromMap(jsonDecode(json));
}
