part of '../todos_screen.dart';

/// Widget que representa un ítem individual de la lista de TODOs.
///
/// Incluye información de la tarea, una opción para marcar como completada,
/// y un botón para eliminarla.
class _TodoItem extends ConsumerWidget {
  const _TodoItem(
      {super.key,
      required this.todo,
      required this.onUpdated,
      required this.onDeleted});

  final Todo todo;
  final Function(Todo) onUpdated;
  final Function(Todo) onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                width: 1, color: theme.colorScheme.primaryContainer)),
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (v) => ref.read(todosControllerProvider).updateTodo(
                context,
                todoId: todo.id,
                updateTodoDto: UpdateTodoDto(isCompleted: v),
                onUpdated: onUpdated,
              ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            color: todo.isCompleted ? Colors.grey : null,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          DateFormat('dd MMMM y HH:mm a').format(todo.dueDate),
          style: TextStyle(color: theme.colorScheme.primaryContainer),
        ),
        trailing: IconButton(
          onPressed: () => ref.read(todosControllerProvider).deleteTodo(context,
              todoId: todo.id, onDeleted: () => onDeleted(todo)),
          icon: Icon(
            Icons.delete_forever_rounded,
            color: theme.colorScheme.primaryContainer,
          ),
        ),
      ),
    );
  }
}
