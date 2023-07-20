import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/students.dart';

abstract class IStudentRepository {
  Future<List<Student>> findAll();
  Future<Student> findById(int id);
  Future<void> insert(Student student);
  Future<void> update(Student student);
  Future<void> deleteById(Student student);
}

class StudentRepository extends IStudentRepository {
  @override
  Future<List<Student>> findAll() async {
    final studentsResult = await http.get(Uri.parse('http://localhost:8080/students'));

    if (studentsResult.statusCode != 200) {
      throw Exception();
    }

    final studentsData = jsonDecode(studentsResult.body) as List;

    return studentsData.map<Student>((student) {
      return Student.fromMap(student);
    }).toList();
  }

  @override
  Future<Student> findById(int id) async {
    final studentResult = await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (studentResult.statusCode != 200) {
      throw Exception();
    }

    if (studentResult.body == '{}') {
      throw Exception('Estudante não encontrado');
    }

    // final studentData = jsonDecode(studentResult.body);

    return Student.fromJson(studentResult.body);
  }

  @override
  Future<void> insert(Student student) async {
    final response = await http.post(
      Uri.parse('http:localhost:8080/students'),
      body: student.toJson(),
      headers: {
        'content-type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  @override
  Future<void> update(Student student) async {
    final response = await http.put(
      Uri.parse('http:localhost:8080/students/${student.id}'),
      body: student.toJson(),
      headers: {
        'content-type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw new Exception();
    }
  }

  @override
  Future<void> deleteById(Student student) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }
}
