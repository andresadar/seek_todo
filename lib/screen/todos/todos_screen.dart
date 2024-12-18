import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:seek_todo/core/resource/custom_animations.dart';
import 'package:seek_todo/screen/todos/messages/todos_messages.dart';
import 'package:seek_todo/screen/todos/todos_controller.dart';

// Widgets
part 'widgets/todo_list.dart';
part 'widgets/todo_item.dart';

/// Pantalla principal para gestionar los TODOs.
///
/// Esta pantalla muestra una lista de tareas, permite añadir nuevas, actualizarlas,
/// y eliminarlas. Está diseñada como un `ConsumerStatefulWidget` para aprovechar
/// las funcionalidades de `Riverpod` para la gestión del estado.
class TodosScreen extends ConsumerStatefulWidget {
  const TodosScreen({super.key});

  @override
  ConsumerState<TodosScreen> createState() => _TodosScreenState();
}

/// Estado de la pantalla `TodosScreen`.
///
/// Encargado de construir la interfaz de usuario y gestionar las
/// interacciones con el usuario.
class _TodosScreenState extends ConsumerState<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          _buildAppBar(),

          // Todos list
          _buildTodosList(),
        ],
      ),
    );
  }

  /// Construye el `SliverAppBar` para la pantalla de TODOs.
  ///
  /// Incluye un título y un subtítulo estilizados.
  SliverAppBar _buildAppBar() {
    final theme = Theme.of(context);

    return SliverAppBar.large(
      title: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          "SEEK ToDo",
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primaryContainer,
              fontWeight: FontWeight.w700),
        ),
        subtitle: Text("We can change the world!",
            style: theme.textTheme.titleMedium
                ?.copyWith(color: theme.colorScheme.primaryContainer)),
      ),
    );
  }

  /// Construye la lista de TODOs como un `SliverFillRemaining`.
  ///
  /// Muestra un `FutureBuilder` para obtener los TODOs, manejando estados
  /// de carga y error.
  SliverFillRemaining _buildTodosList() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FutureBuilder(
                future: ref.read(todosControllerProvider).getAllTodos(),
                builder: (context, snapshot) {
                  // Estado de carga
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }

                  // Estado de error
                  if (snapshot.hasError) {
                    return Center(child: Text("Todos error"));
                  }

                  // Estado de éxito
                  final todos = snapshot.data ?? [];
                  return _TodosList(todos: todos);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
