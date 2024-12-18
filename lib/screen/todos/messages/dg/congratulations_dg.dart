part of '../todos_messages.dart';

/// Diálogo de felicitaciones que muestra una animación de Lottie.
///
/// Este diálogo se muestra por 3 segundos y luego se cierra automáticamente.
/// No permite al usuario cerrarlo manualmente.
class _CongratulationsDg extends StatefulWidget {
  const _CongratulationsDg({super.key});

  @override
  State<_CongratulationsDg> createState() => _CongratulationsDgState();
}

class _CongratulationsDgState extends State<_CongratulationsDg> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Configura un temporizador para cerrar el diálogo automáticamente.
    timer =
        Timer(const Duration(milliseconds: 3000), () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          child: Center(
              child: LottieBuilder.asset(
            CustomAnimations.congratulations,
            repeat: false,
          )),
        ),
      ),
    );
  }
}
