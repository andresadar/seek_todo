import 'dart:async';
import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:seek_todo/core/resource/custom_animations.dart';
import 'package:seek_todo/screen/todos/todos_controller.dart';

// Dg
part 'dg/create_todo_dg.dart';
part 'dg/congratulations_dg.dart';

/// Clase que centraliza los mensajes y diálogos relacionados con las tareas.
abstract class TodosMessages {
  /// Muestra un diálogo modal para crear una nueva tarea.
  static Future<dynamic> showCreateTodo(
    BuildContext context, {
    required Function(Todo) onAdded,
  }) =>
      showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        showDragHandle: true,
        context: context,
        builder: (context) => _CreateTodoDg(onAdded: onAdded),
      );

  /// Muestra un diálogo de felicitaciones.
  static void showCongratulations(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) => const _CongratulationsDg(),
      );
}