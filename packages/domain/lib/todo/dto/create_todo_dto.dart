part of '../../domain.dart';

/// DTO para la creación de un ToDo.
///
/// Este objeto se utiliza para transferir los datos necesarios
/// al crear un nuevo ToDo en la aplicación.
class CreateTodoDto {
  /// Título breve de la tarea. Es obligatorio.
  final String title;

  /// Fecha de vencimiento de la tarea. Es opcional.
  final DateTime dueDate;

  /// Constructor del DTO `CreateTodoDto`.
  ///
  /// [title] es obligatorio y representa el título de la tarea.
  /// [description] y [dueDate] son opcionales.
  CreateTodoDto({
    required this.title,
    required this.dueDate,
  });

  /// Convierte el DTO `CreateTodoDto` a un mapa de datos.
  ///
  /// Útil para enviar la información a una API o base de datos.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}
