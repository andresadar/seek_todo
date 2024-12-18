part of '../../infrastructure.dart';

/// Implementación concreta de `TodoDataSource` que interactúa con `SharedPreferences`
/// para almacenar y recuperar los ToDos.
///
/// Esta clase maneja todas las operaciones CRUD (crear, leer, actualizar y eliminar)
/// relacionadas con los ToDos, utilizando `SharedPreferences` como la fuente de almacenamiento.
class TodoService extends TodoDataSource {
  final SharedPreferences _sharedPreferences;

  TodoService({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const _todoKey = "todoKey";

  @override
  Future<List<Todo>> getAllTodos() async {
    try {
      final todosData = _sharedPreferences.getString(_todoKey);

      if (todosData == null) return [];

      // Validar que los datos sean un JSON válido
      try {
        final todosDecode = jsonDecode(todosData);
        if (todosDecode is! List) {
          throw FormatException("Expected a list of todos.");
        }
        return (todosDecode).map((e) => Todo.fromMap(e)).toList();
      } catch (e) {
        // Lanzar una excepción específica si hay un error en la deserialización
        throw FormatException(
            "Error al deserializar los datos de los ToDos: $e");
      }
    } catch (e) {
      // Capturar cualquier otro error inesperado
      rethrow;
    }
  }

  @override
  Future<Todo> createTodo({required CreateTodoDto createTodoDto}) async {
    try {
      final allTodos = await getAllTodos();
      final todo = Todo.fromCreateTodoDto(createTodoDto);
      allTodos.add(todo);

      await _savedAllTodos(todos: allTodos);

      return todo;
    } catch (e) {
      // Añadir más detalles al error si es necesario
      throw Exception("Error al crear el ToDo: $e");
    }
  }

  @override
  Future<void> deleteTodo({required String todoId}) async {
    try {
      final todos = await getAllTodos();

      final todoIndex = todos.indexWhere((e) => e.id == todoId);
      if (todoIndex == -1) throw TodoNotFoundException();

      todos.removeAt(todoIndex);

      await _savedAllTodos(todos: todos);
    } catch (e) {
      // Añadir un mensaje más claro sobre el error
      throw TodoNotFoundException(
          message: "El ToDo con ID $todoId no se encontró.");
    }
  }

  @override
  Future<Todo> updateTodo(
      {required String todoId, required UpdateTodoDto updateTodoDto}) async {
    try {
      final todos = await getAllTodos();

      final todoIndex = todos.indexWhere((e) => e.id == todoId);
      if (todoIndex == -1) throw TodoNotFoundException();

      todos[todoIndex] = todos[todoIndex].copyWith(
        title: updateTodoDto.title,
        isCompleted: updateTodoDto.isCompleted,
        dueDate: updateTodoDto.dueDate,
      );

      await _savedAllTodos(todos: todos);

      return todos[todoIndex];
    } catch (e) {
      // Lanzar una excepción más detallada si no se encuentra el ToDo
      throw TodoNotFoundException(
          message:
              "El ToDo con ID $todoId no se encontró o hubo un error al actualizar.");
    }
  }

  // Guardar lista de todos actualizados
  Future<void> _savedAllTodos({required List<Todo> todos}) async {
    try {
      final todosEncode = jsonEncode(todos.map((e) => e.toMap()).toList());
      await _sharedPreferences.setString(_todoKey, todosEncode);
    } catch (e) {
      // Manejo de errores más detallado en el proceso de guardado
      throw Exception("Error al guardar los datos de los ToDos: $e");
    }
  }
}
