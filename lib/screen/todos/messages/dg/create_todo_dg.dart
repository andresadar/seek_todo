part of '../todos_messages.dart';

/// Diálogo para la creación de una nueva tarea.
///
/// Este diálogo incluye un formulario con validación para el título,
/// la fecha y la hora. Los datos se envían a través del callback [onAdded].
class _CreateTodoDg extends ConsumerStatefulWidget {
  const _CreateTodoDg({required this.onAdded});

  /// Callback que se ejecuta cuando se crea una nueva tarea.
  final Function(Todo) onAdded;

  @override
  ConsumerState<_CreateTodoDg> createState() => _CreateTodoDgState();
}

class _CreateTodoDgState extends ConsumerState<_CreateTodoDg> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController title;
  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
  }

  @override
  void dispose() {
    title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Create task"),
            ),
            _buildTitle(),
            _buildDates(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  /// Construye el campo de texto para el título.
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: const InputDecoration(hintText: "Title"),
        controller: title,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) return "The title cannot be empty";
          return null;
        },
      ),
    );
  }

  /// Construye los campos para seleccionar la fecha y la hora.
  Widget _buildDates() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        key: Key(DateTime.now().toString()),
        children: [
          // Campo de fecha
          Expanded(
            flex: 2,
            child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              readOnly: true,
              onTap: () async {
                final dt = await showDatePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendar,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (dt != null) setState(() => date = dt);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue:
                  date != null ? DateFormat('dd MMMM y').format(date!) : null,
              decoration: const InputDecoration(
                hintText: "Date",
                prefixIcon: Icon(Icons.calendar_today_rounded),
              ),
              validator: (v) {
                if (date == null) return "Enter the date";
                return null;
              },
            ),
          ),
          const SizedBox(width: 10),
          // Campo de hora
          Expanded(
            child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              readOnly: true,
              onTap: () async {
                final tm = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.dialOnly,
                );
                if (tm != null) setState(() => time = tm);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: time != null
                  ? DateFormat('HH:mm')
                      .format(DateTime(2000, 1, 1, time!.hour, time!.minute))
                  : null,
              decoration: const InputDecoration(
                hintText: "Time",
                prefixIcon: Icon(Icons.access_time),
              ),
              validator: (v) {
                if (time == null) return "Enter the time";
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Construye el botón para crear la tarea.
  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        final isValidForm = formKey.currentState?.validate() ?? false;
        if (!isValidForm) return;

        ref.read(todosControllerProvider).createTodo(
              context,
              createTodoDto: CreateTodoDto(
                title: title.text,
                dueDate: date!.copyWith(hour: time!.hour, minute: time!.minute),
              ),
              onAdded: widget.onAdded,
            );
      },
      child: const Text("Create"),
    );
  }
}
