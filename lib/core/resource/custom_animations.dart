/// Clase para gestionar las rutas de las animaciones personalizadas.
///
/// Esta clase utiliza el patrón Singleton para centralizar y reutilizar
/// las rutas de archivos Lottie u otras animaciones en la aplicación.
/// Define las constantes de las rutas a las animaciones ubicadas en el
/// directorio de assets.
class CustomAnimations {
  /// Instancia única de [CustomAnimations].
  static final CustomAnimations _singleton = CustomAnimations._internal();

  /// Constructor de fábrica para obtener la instancia única.
  factory CustomAnimations() {
    return _singleton;
  }

  /// Constructor privado para evitar múltiples instancias.
  CustomAnimations._internal();

  /// Ruta base de las animaciones.
  static const _base = "assets/animations";

  /// Ruta para la animación de lista vacía.
  static const todosEmpty = '$_base/todos_empty.json';

  /// Ruta para la animación de felicitaciones.
  static const congratulations = '$_base/congratulations.json';
}