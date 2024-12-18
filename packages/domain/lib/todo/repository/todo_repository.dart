part of '../../domain.dart';

/// Abstracción del repositorio de ToDo.
///
/// Define los métodos necesarios para interactuar con la fuente de datos de los ToDos.
/// Esta interfaz establece las operaciones fundamentales para manejar la creación,
/// actualización y eliminación de tareas (ToDos).
abstract class TodoRepository {
  /// Obtiene todos los ToDos.
  ///
  /// Este método devuelve una lista de todas las tareas disponibles.
  /// Se puede utilizar para mostrar todas las tareas en la interfaz de usuario.
  ///
  /// Retorna:
  /// - Una lista de objetos [Todo] que representa todas las tareas.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones relacionadas con errores al obtener los datos.
  Future<List<Todo>> getAllTodos();

  /// Crea un nuevo ToDo.
  ///
  /// Este método recibe un objeto [CreateTodoDto] que contiene los datos
  /// necesarios para crear una nueva tarea y devuelve la instancia creada del modelo [Todo].
  ///
  /// Parámetros:
  /// - [createTodoDto]: Objeto DTO con los datos necesarios para crear el ToDo.
  ///
  /// Retorna:
  /// - Una instancia del modelo [Todo] que representa la tarea recién creada.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones relacionadas con errores en la fuente de datos.
  Future<Todo> createTodo({required CreateTodoDto createTodoDto});

  /// Actualiza un ToDo existente.
  ///
  /// Este método recibe un objeto [UpdateTodoDto] que contiene los datos a actualizar
  /// para un ToDo existente y devuelve la instancia actualizada del modelo [Todo].
  ///
  /// Parámetros:
  /// - [todoId]: Id del toDo.
  /// - [updateTodoDto]: Objeto DTO con los datos necesarios para actualizar el ToDo.
  ///
  /// Retorna:
  /// - Una instancia del modelo [Todo] que representa la tarea actualizada.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones relacionadas con errores en la fuente de datos,
  ///   como si el ToDo especificado no existe.
  Future<Todo> updateTodo(
      {required String todoId, required UpdateTodoDto updateTodoDto});

  /// Elimina un ToDo existente.
  ///
  /// Este método elimina un ToDo basado en su identificador único [todoId].
  ///
  /// Parámetros:
  /// - [todoId]: Identificador único del ToDo que se desea eliminar.
  ///
  /// Retorna:
  /// - Nada ([void]), pero asegura la eliminación de la tarea.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones si el ToDo no existe o si ocurre un error
  ///   al intentar eliminarlo en la fuente de datos.
  Future<void> deleteTodo({required String todoId});
}
