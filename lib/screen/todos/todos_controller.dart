import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seek_todo/core/dependency_injection/dependency_injection.dart';
import 'package:seek_todo/screen/todos/messages/todos_messages.dart';

/// Controlador que gestiona las operaciones relacionadas con los TODOs.
///
/// Este controlador actúa como intermediario entre la capa de presentación
/// y la capa de dominio. Utiliza un caso de uso (`TodoUseCase`) para realizar
/// las operaciones de negocio relacionadas con los TODOs.
class TodosController {
  final TodoUseCase _todoUseCase;

  /// Constructor del controlador.
  ///
  /// Requiere una instancia de [TodoUseCase] para manejar las operaciones
  /// relacionadas con los TODOs.
  TodosController({required TodoUseCase todoUseCase})
      : _todoUseCase = todoUseCase;

  /// Obtiene una lista de todas las tareas (TODOs).
  ///
  /// Retorna una lista de objetos [Todo].
  Future<List<Todo>> getAllTodos() => _todoUseCase.getAllTodos();

  /// Crea una nueva tarea (TODO).
  ///
  /// [context]: El contexto de la aplicación.
  /// [createTodoDto]: DTO con los datos para la creación de la tarea.
  /// [onAdded]: Callback que se ejecuta después de que la tarea ha sido creada
  /// exitosamente.
  ///
  /// Si ocurre un error, muestra un mensaje de error utilizando `Fluttertoast`.
  Future<void> createTodo(BuildContext context,
      {required CreateTodoDto createTodoDto,
      required Function(Todo) onAdded}) async {
    try {
      final todo = await _todoUseCase.createTodo(createTodoDto: createTodoDto);

      if (!context.mounted) return;
      onAdded(todo);
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "$e");
    }
  }

  /// Elimina una tarea (TODO).
  ///
  /// [context]: El contexto de la aplicación.
  /// [todoId]: Identificador de la tarea a eliminar.
  /// [onDeleted]: Callback que se ejecuta después de que la tarea ha sido
  /// eliminada exitosamente.
  ///
  /// Si ocurre un error, muestra un mensaje de error utilizando `Fluttertoast`.
  Future<void> deleteTodo(BuildContext context,
      {required String todoId, required Function() onDeleted}) async {
    try {
      await _todoUseCase.deleteTodo(todoId: todoId);

      if (!context.mounted) return;
      onDeleted();
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  /// Actualiza una tarea (TODO).
  ///
  /// [context]: El contexto de la aplicación.
  /// [todoId]: Identificador de la tarea a actualizar.
  /// [updateTodoDto]: DTO con los datos para actualizar la tarea.
  /// [onUpdated]: Callback que se ejecuta después de que la tarea ha sido
  /// actualizada exitosamente.
  ///
  /// Si la tarea es completada, muestra un diálogo de felicitaciones.
  /// Si ocurre un error, muestra un mensaje de error utilizando `Fluttertoast`.
  Future<void> updateTodo(BuildContext context,
      {required String todoId,
      required UpdateTodoDto updateTodoDto,
      required Function(Todo) onUpdated}) async {
    try {
      final todo = await _todoUseCase.updateTodo(
          todoId: todoId, updateTodoDto: updateTodoDto);

      if (!context.mounted) return;
      onUpdated(todo);
      Navigator.popUntil(context, (route) => route.isFirst);

      if (todo.isCompleted) TodosMessages.showCongratulations(context);
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "$e");
    }
  }
}

/// Proveedor de la instancia de [TodosController].
///
/// Utiliza el paquete `Provider` para inyectar automáticamente una instancia
/// de `TodosController` configurada con la implementación de `TodoUseCase`
/// registrada en el [DependencyInjector].
final todosControllerProvider = Provider.autoDispose((ref) =>
    TodosController(todoUseCase: DependencyInjector().getIt<TodoUseCase>()));