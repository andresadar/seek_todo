part of '../messages.dart';

/// Clase que representa un diálogo de carga.
///
/// Este widget muestra un indicador de progreso adaptativo dentro de un diálogo.
/// Incluye un efecto de desenfoque en el fondo y no permite que el usuario lo cierre
/// manualmente (sin interacción).
///
/// Usado principalmente para indicar que una operación está en progreso.
class _LoadingDg extends StatelessWidget {
  /// Constructor de [_LoadingDg].
  const _LoadingDg({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      /// Impide que el diálogo de carga sea cerrado manualmente.
      onPopInvokedWithResult: (didPop, _) async => false,
      child: BackdropFilter(
        /// Aplica un efecto de desenfoque al fondo.
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Dialog(
          /// Configuración de forma y apariencia del diálogo.
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: const Center(
            /// Indicador de carga adaptable (diferente diseño en iOS/Android).
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}