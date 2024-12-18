import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seek_todo/routes/pages.dart';
import 'package:seek_todo/routes/routes.dart';
import 'package:seek_todo/theme/custom_theme.dart';

import 'core/dependency_injection/dependency_injection.dart';

/// Punto de entrada principal de la aplicación.
void main() async {
  // Asegura la inicialización de los widgets de Flutter.
  WidgetsFlutterBinding.ensureInitialized();

  // Configura las dependencias necesarias utilizando un inyector de dependencias.
  await DependencyInjector().setup();

  /// Establece la orientación preferida de la aplicación en modo vertical.
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Inicia la aplicación con soporte para el estado global mediante `ProviderScope`.
  runApp(ProviderScope(child: const MyApp()));
}

/// Clase principal de la aplicación.
class MyApp extends StatelessWidget {
  /// Constructor de la clase [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación.
      title: 'Seek ToDo',

      // Ruta inicial de la aplicación.
      initialRoute: MyRoutes.initial,

      // Rutas disponibles en la aplicación.
      routes: Pages.routes,

      // Tema para modo claro.
      theme: CustomTheme.light,

      // Tema para modo oscuro.
      darkTheme: CustomTheme.dark,

      // Modo de tema según las preferencias del sistema.
      themeMode: ThemeMode.system,
    );
  }
}
