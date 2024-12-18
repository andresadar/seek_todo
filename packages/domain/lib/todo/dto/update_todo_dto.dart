part of '../../domain.dart';

/// DTO para la actualización de un ToDo.
///
/// Este objeto se utiliza para transferir los datos necesarios
/// al actualizar un ToDo existente en la aplicación.
class UpdateTodoDto {
  /// Título breve de la tarea. Es opcional.
  final String? title;

  /// Indica si la tarea está completada o no. Es opcional.
  final bool? isCompleted;

  /// Fecha de vencimiento de la tarea. Es opcional.
  final DateTime? dueDate;

  /// Constructor del DTO `UpdateTodoDto`.
  ///
  /// Todos los campos son opcionales, permitiendo actualizaciones parciales.
  UpdateTodoDto({
    this.title,
    this.isCompleted,
    this.dueDate,
  });

  /// Convierte el DTO `UpdateTodoDto` a un mapa de datos.
  ///
  /// Útil para enviar solo las propiedades que se quieren actualizar.
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    if (title != null) map['title'] = title;
    if (isCompleted != null) map['isCompleted'] = isCompleted;
    if (dueDate != null) map['dueDate'] = dueDate!.toIso8601String();
    return map;
  }
}