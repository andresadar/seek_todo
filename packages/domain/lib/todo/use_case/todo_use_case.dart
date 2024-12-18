part of '../../domain.dart';

/// Caso de uso para manejar la lógica de negocio de los ToDos.
///
/// Esta clase actúa como una capa intermedia entre el repositorio de ToDos
/// y los controladores o interfaces de usuario. Contiene métodos que encapsulan
/// la lógica de negocio para crear, actualizar y eliminar tareas.
///
/// Utiliza un repositorio [TodoRepository] para realizar las operaciones
/// subyacentes relacionadas con los datos.
class TodoUseCase {
  /// Repositorio utilizado para manejar los datos de los ToDos.
  final TodoRepository _todoRepository;

  /// Constructor de `TodoUseCase`.
  ///
  /// Parámetros:
  /// - [todoRepository]: Implementación concreta de [TodoRepository]
  ///   que se utiliza para interactuar con la fuente de datos.
  ///
  /// El repositorio es inyectado, permitiendo pruebas más fáciles y
  /// flexibilidad en la implementación.
  TodoUseCase({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  /// Obtiene todos los ToDos.
  ///
  /// Este método encapsula la lógica de negocio para obtener todas las tareas
  /// existentes, delegando la operación al repositorio.
  ///
  /// Retorna:
  /// - Una lista de instancias del modelo [Todo] que representa todas las tareas.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones relacionadas con la lógica del repositorio
  ///   o si ocurre un error al obtener los datos.
  Future<List<Todo>> getAllTodos() => _todoRepository.getAllTodos();

  /// Crea un nuevo ToDo.
  ///
  /// Este método encapsula la lógica de negocio necesaria para la creación
  /// de un ToDo, delegando la operación al repositorio.
  ///
  /// Parámetros:
  /// - [createTodoDto]: Objeto DTO con los datos necesarios para crear el ToDo.
  ///
  /// Retorna:
  /// - Una instancia del modelo [Todo] que representa la tarea recién creada.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones relacionadas con la lógica del repositorio
  ///   o validaciones fallidas.
  Future<Todo> createTodo({required CreateTodoDto createTodoDto}) =>
      _todoRepository.createTodo(createTodoDto: createTodoDto);

  /// Actualiza un ToDo existente.
  ///
  /// Este método encapsula la lógica de negocio necesaria para actualizar
  /// un ToDo, delegando la operación al repositorio.
  ///
  /// Parámetros:
  /// - [todoId]: Id del ToDo.
  /// - [updateTodoDto]: Objeto DTO con los datos necesarios para actualizar el ToDo.
  ///
  /// Retorna:
  /// - Una instancia del modelo [Todo] que representa la tarea actualizada.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones relacionadas con la lógica del repositorio
  ///   o si el ToDo no existe.
  Future<Todo> updateTodo(
          {required String todoId, required UpdateTodoDto updateTodoDto}) =>
      _todoRepository.updateTodo(todoId: todoId, updateTodoDto: updateTodoDto);

  /// Elimina un ToDo existente.
  ///
  /// Este método encapsula la lógica de negocio necesaria para eliminar
  /// un ToDo, delegando la operación al repositorio.
  ///
  /// Parámetros:
  /// - [todoId]: Identificador único del ToDo que se desea eliminar.
  ///
  /// Retorna:
  /// - Nada ([void]), pero asegura que la tarea sea eliminada.
  ///
  /// Excepciones:
  /// - Puede lanzar excepciones relacionadas con la lógica del repositorio
  ///   o si el ToDo no existe.
  Future<void> deleteTodo({required String todoId}) =>
      _todoRepository.deleteTodo(todoId: todoId);
}
