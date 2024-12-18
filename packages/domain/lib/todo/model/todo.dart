part of '../../domain.dart';

/// Modelo de ToDo para la aplicación.
///
/// Representa una tarea individual en la aplicación con propiedades
/// comunes como título, estado de completado y fechas.
class Todo {
  /// Identificador único de la tarea.
  final String id;

  /// Título breve de la tarea.
  final String title;

  /// Indica si la tarea está completada o no.
  final bool isCompleted;

  /// Fecha de creación de la tarea.
  final DateTime createdAt;

  /// Fecha de vencimiento de la tarea.
  final DateTime dueDate;

  /// Constructor del modelo `Todo`.
  ///
  /// [id] es obligatorio y debe ser único para identificar cada tarea.
  /// [title] es obligatorio y representa el título de la tarea.
  /// [isCompleted] tiene un valor predeterminado de `false`.
  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    DateTime? createdAt,
    required this.dueDate,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Crea una copia del objeto actual con modificaciones.
  ///
  /// Permite crear una nueva instancia con cambios en propiedades específicas,
  /// mientras se mantiene el resto de las propiedades sin cambios.
  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  /// Crea una instancia de `Todo` desde un mapa de datos.
  ///
  /// Útil para deserialización (como leer desde una base de datos o una API).
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      dueDate: DateTime.parse(map['dueDate']),
    );
  }

  /// Crea una instancia de `Todo` desde un `CreateTodoDto`.
  ///
  /// Permite construir un modelo `Todo` a partir de los datos proporcionados
  /// por el DTO para la creación de tareas.
  factory Todo.fromCreateTodoDto(CreateTodoDto createTodoDto) {
    return Todo(
      id: _generateUniqueId(),
      title: createTodoDto.title,
      dueDate: createTodoDto.dueDate,
    );
  }

  /// Convierte el modelo `Todo` en un mapa de datos.
  ///
  /// Útil para serialización (como guardar en una base de datos o enviar a una API).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
    };
  }

  /// Genera un UUID único
  static String _generateUniqueId() {
    return Uuid().v4();
  }
}
