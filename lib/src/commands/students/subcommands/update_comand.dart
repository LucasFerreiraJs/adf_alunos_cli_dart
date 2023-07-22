import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/students.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  final StudentRepository studentRepository;
  final ProductRepository productRepository;
  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentRepository) : productRepository = ProductRepository() {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    if (argResults?['file'] == null || argResults?['id'] == null) {
      print('Favor, verificar arquivo csv ou id enviado');
      return;
    }

    final filePath = argResults!['file'];
    final id = argResults!['id'];

    final students = File(filePath).readAsLinesSync();
    print(students);
    print('Aguarde, atualizando dados do aluno');
    print('------------------------------------');

    if (students.length > 1) {
      print('Arquivo deve conter informação de apenas 1 (um) aluno');
      return;
    } else if (students.isEmpty) {
      print('O arquivo está vazio');
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final courseCsv = studentData[2].split(',').map((text) => text.trim()).toList();

    var coursesFutures = courseCsv.map((courseName) async {
      // * retorna tipo Course
      final course = await productRepository.findByName(courseName);
      course.isStudent = true;

      return course;
    }).toList();

    final courses = await Future.wait(coursesFutures);
    print('courseName fora $courses');

    final studentModel = Student(
      id: int.parse(id),
      name: studentData[0],
      age: int.tryParse(studentData[1]),
      nameCourses: courseCsv,
      courses: courses,
      address: Address(
        street: studentData[3],
        number: int.parse(studentData[4]),
        zipCode: studentData[5],
        city: City(
          id: 1,
          name: studentData[6],
        ),
        phone: Phone(
          ddd: int.parse(studentData[7]),
          phone: studentData[8],
        ),
      ),
    );

    print('aluno ${studentModel.name} está sendo inserido ');
    await studentRepository.update(studentModel);

    print('-------------------');
    print('Aluno atualizado com sucesso');
  }
}
