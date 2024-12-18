import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/domain.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late TodoUseCase todoUseCase;
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();
    todoUseCase = TodoUseCase(todoRepository: mockRepository);
  });

  group('TodoUseCase', () {
    test('getAllTodos() retorna una lista de ToDos', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => [
            Todo(
              id: '1',
              title: 'Tarea',
              dueDate: DateTime(2024, 1, 1),
            ),
          ]);

      final todos = await todoUseCase.getAllTodos();

      expect(todos.length, 1);
      expect(todos.first.title, 'Tarea');
    });

    test('createTodo() llama al repositorio con los datos correctos', () async {
      final dto =
          CreateTodoDto(title: 'Nueva tarea', dueDate: DateTime(2024, 1, 1));

      when(mockRepository.createTodo(createTodoDto: dto)).thenAnswer(
        (_) async => Todo(
          id: '1',
          title: 'Nueva tarea',
          dueDate: dto.dueDate,
        ),
      );

      final todo = await todoUseCase.createTodo(createTodoDto: dto);

      expect(todo.id, isNotEmpty);
      expect(todo.title, 'Nueva tarea');
    });
  });
}
