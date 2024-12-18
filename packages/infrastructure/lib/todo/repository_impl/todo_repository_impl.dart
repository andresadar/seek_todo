part of '../../infrastructure.dart';

/// Implementación concreta de `TodoRepository`
/// que delega las operaciones CRUD a una fuente de datos (`TodoDataSource`).
///
/// Esta clase actúa como un intermediario entre la lógica de negocio (casos de uso)
/// y las fuentes de datos específicas (en este caso, `TodoDataSource`).
class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource _todoDataSource;

  TodoRepositoryImpl({required TodoDataSource todoDataSource})
      : _todoDataSource = todoDataSource;

  @override
  Future<List<Todo>> getAllTodos() => _todoDataSource.getAllTodos();

  @override
  Future<Todo> createTodo({required CreateTodoDto createTodoDto}) =>
      _todoDataSource.createTodo(createTodoDto: createTodoDto);

  @override
  Future<Todo> updateTodo(
          {required String todoId, required UpdateTodoDto updateTodoDto}) =>
      _todoDataSource.updateTodo(todoId: todoId, updateTodoDto: updateTodoDto);

  @override
  Future<void> deleteTodo({required String todoId}) =>
      _todoDataSource.deleteTodo(todoId: todoId);
}