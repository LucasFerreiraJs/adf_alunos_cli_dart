import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class DeleteById extends Command {
  final StudentRepository studentRepository;
  @override
  String get description => 'Delete student by id';

  @override
  String get name => 'delete';

  DeleteById(this.studentRepository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Envie o Id do Aluno para ser deletado');
      return;
    }
    print('Aguarde...');
    var id = int.parse(argResults!['id']);

    var getStudent = await studentRepository.findById(id);
    print(getStudent);

    // if (!getStudent) {
    //   print('Aluno com id $id não encontrado');
    //   return;
    // }

    print('Confirma a exclusão do aluno ${getStudent.name}? (S ou N)');
    var inputConfirm = stdin.readLineSync();

    if (inputConfirm?.toLowerCase() == 's') {
      await studentRepository.deleteById(id);
      print('---------------------------');
      print('Aluno deletado com sucesso');
      return;
    } else if (inputConfirm?.toLowerCase() == 'n') {
      print('Operação cancelada');
      return;
    }

    print('por favor,apenas S ou N');
  }
}
