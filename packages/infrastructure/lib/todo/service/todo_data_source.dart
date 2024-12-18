part of '../../infrastructure.dart';

/// Abstracción de la fuente de datos para los ToDos.
///
/// Esta clase define las operaciones necesarias para interactuar con la fuente de datos de los ToDos.
/// Las implementaciones concretas de esta clase pueden utilizar distintas fuentes de datos, como bases de datos locales, APIs, etc.
abstract class TodoDataSource {
  /// Obtiene todos los ToDos almacenados.
  ///
  /// Este método devuelve una lista de objetos `Todo` almacenados en la fuente de datos.
  ///
  /// Retorna:
  /// - [List<Todo>]: Lista de todos los ToDos.
  Future<List<Todo>> getAllTodos();

  /// Crea un nuevo ToDo en la fuente de datos.
  ///
  /// Este método crea un nuevo ToDo a partir de un objeto `CreateTodoDto` y lo guarda en la fuente de datos.
  ///
  /// Parámetros:
  /// - [createTodoDto]: Datos necesarios para crear el ToDo.
  ///
  /// Retorna:
  /// - [Todo]: El ToDo recién creado.
  Future<Todo> createTodo({required CreateTodoDto createTodoDto});

  /// Actualiza un ToDo existente en la fuente de datos.
  ///
  /// Este método actualiza los datos de un ToDo existente a partir de un objeto `UpdateTodoDto`.
  ///
  /// Parámetros:
  /// - [todoId]: El ID del ToDo a actualizar.
  /// - [updateTodoDto]: Los nuevos datos para el ToDo.
  ///
  /// Retorna:
  /// - [Todo]: El ToDo actualizado.
  Future<Todo> updateTodo(
      {required String todoId, required UpdateTodoDto updateTodoDto});

  /// Elimina un ToDo de la fuente de datos.
  ///
  /// Este método elimina un ToDo identificado por su ID de la fuente de datos.
  ///
  /// Parámetros:
  /// - [todoId]: El ID del ToDo a eliminar.
  Future<void> deleteTodo({required String todoId});
}
