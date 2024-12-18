import 'package:flutter_test/flutter_test.dart';
import 'package:domain/domain.dart';

void main() {
  group('CreateTodoDto', () {
    test('toMap() devuelve un mapa válido', () {
      final dto = CreateTodoDto(title: 'Nueva tarea', dueDate: DateTime(2024, 1, 1));

      final result = dto.toMap();

      expect(result['title'], 'Nueva tarea');
      expect(result['dueDate'], '2024-01-01T00:00:00.000');
    });
  });

  group('UpdateTodoDto', () {
    test('toMap() devuelve un mapa válido solo con campos no nulos', () {
      final dto = UpdateTodoDto(title: 'Tarea actualizada', isCompleted: true);

      final result = dto.toMap();

      expect(result['title'], 'Tarea actualizada');
      expect(result['isCompleted'], true);
      expect(result.containsKey('dueDate'), false);
    });
  });

  group('Todo', () {
    test('fromMap() crea un Todo válido', () {
      final map = {
        'id': '1',
        'title': 'Tarea',
        'isCompleted': false,
        'createdAt': '2024-01-01T00:00:00.000',
        'dueDate': '2024-01-10T00:00:00.000'
      };

      final todo = Todo.fromMap(map);

      expect(todo.id, '1');
      expect(todo.title, 'Tarea');
      expect(todo.isCompleted, false);
      expect(todo.createdAt, DateTime(2024, 1, 1));
      expect(todo.dueDate, DateTime(2024, 1, 10));
    });

    test('copyWith() retorna un nuevo Todo con campos actualizados', () {
      final todo = Todo(
        id: '1',
        title: 'Tarea',
        dueDate: DateTime(2024, 1, 10),
      );

      final updatedTodo = todo.copyWith(title: 'Nueva Tarea');

      expect(updatedTodo.title, 'Nueva Tarea');
      expect(updatedTodo.id, '1'); // Mantiene el mismo ID.
    });
  });
}