import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/infrastructure.dart';

/// Clase encargada de gestionar la inyección de dependencias.
///
/// Esta clase sigue el patrón Singleton para asegurarse de que solo haya una
/// instancia de la inyección de dependencias en toda la aplicación.
/// Utiliza la librería `GetIt` para registrar y resolver las dependencias
/// de la aplicación de manera centralizada.
class DependencyInjector {
  // Instancia singleton de DependencyInjector.
  static final DependencyInjector _singleton = DependencyInjector._internal();

  /// Constructor de fábrica que devuelve la única instancia de `DependencyInjector`.
  factory DependencyInjector() {
    return _singleton;
  }

  // Constructor interno privado que asegura la creación de la única instancia.
  DependencyInjector._internal();

  // Instancia de GetIt utilizada para gestionar la inyección de dependencias.
  final GetIt getIt = GetIt.instance;

  // Instancia de SharedPreferences, utilizada para almacenar datos locales.
  late SharedPreferences _sharedPreferences;

  /// Configura las dependencias e inicializa los servicios.
  ///
  /// Este método configura e inyecta todas las dependencias necesarias
  /// para la aplicación. Se encarga de inicializar `SharedPreferences` y
  /// registrar las dependencias clave como los repositorios y casos de uso
  /// de ToDo en el contenedor `GetIt`.
  ///
  /// El orden de las configuraciones es importante, ya que las dependencias
  /// pueden depender de otras. Por ejemplo, el repositorio de ToDos depende
  /// de un servicio de datos, por lo que debe configurarse antes.
  Future<void> setup() async {
    // Inicializa SharedPreferences
    _sharedPreferences = await SharedPreferences.getInstance();

    // Crear la implementación del repositorio de ToDos
    final todoRepositoryImpl = TodoRepositoryImpl(
        todoDataSource: TodoService(sharedPreferences: _sharedPreferences));

    ////////////////// INYECCIÓN DE SINGLETONS
    // Registrar el caso de uso de ToDo como un Singleton en GetIt
    getIt.registerSingleton<TodoUseCase>(
        TodoUseCase(todoRepository: todoRepositoryImpl));
  }
}