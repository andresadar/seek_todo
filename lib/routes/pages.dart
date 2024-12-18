import 'package:flutter/material.dart';
import 'package:seek_todo/routes/routes.dart';
import 'package:seek_todo/screen/todos/todos_screen.dart';

/// Clase abstracta que define las rutas de navegación de la aplicación.
///
/// Contiene un mapa que asocia nombres de rutas con sus widgets correspondientes.
/// Esta clase actúa como punto central para gestionar la navegación de las pantallas.
abstract class Pages {
  /// Mapa de rutas de la aplicación.
  ///
  /// Asocia cadenas de texto que representan las rutas con funciones que devuelven
  /// el widget correspondiente para cada pantalla. 
  /// 
  /// Uso:
  /// ```dart
  /// MaterialApp(
  ///   initialRoute: MyRoutes.initial,
  ///   routes: Pages.routes,
  /// );
  /// ```
  static Map<String, Widget Function(BuildContext)> routes = {
    /// Ruta inicial de la aplicación, que apunta a [TodosScreen].
    MyRoutes.initial: (_) => const TodosScreen(),
  };
}