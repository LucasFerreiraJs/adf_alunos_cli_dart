import 'package:args/args.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  // final argParser = ArgParser();
  // argParser.addFlag('data', abbr: 'd');
  // argParser.addOption('name', abbr: 'n');
  // argParser.addOption('template', abbr: 't');

  // final argResult = argParser.parse(arguments);
  // print('${argResult['data']}');
  // print('${argResult['name']}');
  // print('${argResult['template']}');

  CommandRunner('ADF CLI', 'ADF CLI')
    ..addCommand(ExemploCommand())
    ..run(arguments);
}

class ExemploCommand extends Command {
  @override
  // TODO: implement description
  String get description => 'Éxemplo de comando';

  @override
  // TODO: implement name
  String get name => 'exemplo';

  @override
  void run() {
    print('executar qualquer coisa');
  }
}
