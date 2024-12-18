part of '../../infrastructure.dart';

/// Excepción lanzada cuando no se encuentra un ToDo en la fuente de datos.
///
/// Esta clase es una excepción personalizada que se utiliza cuando
/// no se puede localizar un ToDo por su ID. Puede ser útil para manejar
/// errores específicos cuando se intenta realizar operaciones CRUD con
/// ToDos inexistentes.
class TodoNotFoundException implements Exception {
  final String message;

  TodoNotFoundException({this.message = "ToDo not found"});

  @override
  String toString() => message;
}