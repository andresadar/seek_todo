part of '../todos_screen.dart';

/// Widget que representa la lista de TODOs.
///
/// Muestra cada tarea utilizando el widget `_TodoItem`. También incluye
/// un botón para añadir nuevas tareas.
class _TodosList extends StatefulWidget {
  const _TodosList({required this.todos});

  final List<Todo> todos;

  @override
  State<_TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<_TodosList> {
  @override
  Widget build(BuildContext context) {
    // Si no hay tareas, muestra un mensaje de lista vacía.
    if (widget.todos.isEmpty) return _buildEmpty();

    return Column(
      children: [
        // Botón para añadir tarea
        _buildAddTodo(),

        const SizedBox(height: 10),

        // Lista de tareas
        for (var todo in widget.todos)
          _TodoItem(
            todo: todo,
            onUpdated: (v) {
              final todoIndex = widget.todos.indexWhere((e) => e.id == v.id);
              if (todoIndex != -1) {
                setState(() => widget.todos[todoIndex] = v);
              }
            },
            onDeleted: (v) => setState(() => widget.todos.remove(v)),
          ),
      ],
    );
  }

  /// Construye un mensaje para la lista vacía.
  ///
  /// Incluye una animación y un botón para añadir la primera tarea.
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animación
          LottieBuilder.asset(CustomAnimations.todosEmpty, height: 250),

          // Botón para añadir tarea
          _buildAddTodo(),
        ],
      ),
    );
  }

  /// Construye un botón para añadir nuevas tareas.
  TextButton _buildAddTodo() {
    final theme = Theme.of(context);

    return TextButton.icon(
      onPressed: () => TodosMessages.showCreateTodo(
        context,
        onAdded: (v) => setState(() => widget.todos.add(v)),
      ),
      icon: Icon(Icons.add_circle),
      label: Text(
        "Create your first task",
        style: theme.textTheme.bodyLarge
            ?.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}
