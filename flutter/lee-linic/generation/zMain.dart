import 'dart:convert';
import 'dart:io';

final String fileName = 'dashboard';

void main() async {
  String name = fileName.substring(0, 1).toUpperCase() + fileName.substring(1);

  File('generation/$fileName/${fileName}Bloc.dart')
      .create(recursive: true)
      .then((file) => file.writeAsString(File('generation/bloc.dart')
          .readAsStringSync(encoding: utf8)
          .replaceAll('Interface', name)
          .replaceAll('event', '${fileName}Event')
          .replaceAll('state', '${fileName}State')));

  File('generation/$fileName/${fileName}Event.dart')
      .create(recursive: true)
      .then((file) => file.writeAsString(File('generation/event.dart')
          .readAsStringSync(encoding: utf8)
          .replaceAll('Interface', name)));

  File('generation/$fileName/$fileName.dart').create(recursive: true).then(
      (file) => file.writeAsString(
          File('generation/model.dart').readAsStringSync(encoding: utf8)));

  File('generation/$fileName/${fileName}State.dart')
      .create(recursive: true)
      .then((file) => file.writeAsString(File('generation/state.dart')
          .readAsStringSync(encoding: utf8)
          .replaceAll('Interface', name)));

  File('generation/$fileName/${fileName}View.dart')
      .create(recursive: true)
      .then((file) => file.writeAsString(File('generation/view.dart')
          .readAsStringSync(encoding: utf8)
          .replaceAll('Name', name)));
}
