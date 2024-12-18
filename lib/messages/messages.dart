import 'dart:ui';

import 'package:flutter/material.dart';

// DG
part 'dg/loading_dg.dart';

/// Clase abstracta para manejar mensajes de interfaz en la aplicación.
///
/// Define métodos estáticos para mostrar diferentes tipos de mensajes,
/// como diálogos de carga o alertas. Los métodos son de uso directo sin necesidad
/// de instanciar la clase.
abstract class Messages {
  /// Muestra un diálogo de carga.
  ///
  /// Este método invoca un diálogo [_LoadingDg] para indicar al usuario
  /// que una operación está en progreso. El diálogo es modal y no permite
  /// interacción hasta que sea cerrado manualmente por el desarrollador.
  ///
  /// Parámetros:
  /// - [context]: El contexto de construcción actual.
  ///
  /// Uso:
  /// ```dart
  /// Messages.showLoading(context);
  /// ```
  static void showLoading(BuildContext context) => showDialog(
        context: context,
        barrierDismissible:
            false, // Evita que se cierre al tocar fuera del diálogo.
        builder: (context) => const _LoadingDg(),
      );
}
