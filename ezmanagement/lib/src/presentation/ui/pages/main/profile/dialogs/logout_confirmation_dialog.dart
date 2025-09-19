import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// [LogoutConfirmationDialog] muestra una ventana de confirmación
/// para cerrar sesión, utilizando un ValueNotifier para gestionar el estado de carga.
///
/// El diálogo bloquea el cierre durante el procesamiento y muestra un indicador de progreso.
class LogoutConfirmationDialog extends StatelessWidget {
  /// Constructor de LogoutConfirmationDialog.
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Detecta si el modo oscuro está activado.
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    // Color principal de la app.
    final mainBlue = EZColorsApp.ezAppColor;
    // Color de fondo según el modo.
    final bgColor = isDarkmode ? EZColorsApp.darkBackgroud : Colors.white;
    // Color del texto según el modo.
    final textColor = isDarkmode ? Colors.white : Colors.black87;

    /// Controla si el proceso de cierre de sesión está en curso.
    /// Cuando isLoading.value es true, se muestra una animación loading y se bloquea la acción.
    final ValueNotifier<bool> isLoading = ValueNotifier(false);

    /// Acción que confirma el cierre de sesión tras simular un procesamiento.
    Future<void> onConfirm() async {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) {
        isLoading.value = false;
        Navigator.pop(context, true); // Retorna true si confirma.
      }
    }

    // El widget está envuelto en WillPopScope para evitar que se cierre
    // mientras el proceso de cierre de sesión está en curso.
    return WillPopScope(
      // Permite cerrar solo si no está cargando.
      onWillPop: () async => !isLoading.value,
      // ValueListenableBuilder actualiza la UI cuando isLoading cambia.
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, loading, _) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Stack(
              children: [
                // El contenido principal, se deshabilita temporalmente si loading es true.
                Opacity(
                  opacity: loading ? 0.5 : 1,
                  child: AbsorbPointer(
                    absorbing: loading,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Título del diálogo.
                        Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainBlue,
                            fontFamily: 'OpenSansHebrew',
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        // Mensaje principal de confirmación.
                        Text(
                          '¿Estás seguro de que deseas cerrar sesión?',
                          style: TextStyle(
                            fontFamily: 'OpenSansHebrew',
                            fontSize: 16,
                            color: textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        // Botones de acción: Cancelar y Sí, Cerrar Sesión.
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                // Al pulsar Cancelar, retorna false si no está loading.
                                onPressed: loading ? null : () => Navigator.pop(context, false),
                                icon: Icon(
                                  PhosphorIconsBold.x,
                                  color: isDarkmode ? Colors.white : mainBlue,
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: mainBlue.withAlpha(51), // 0.20*255=51
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  side: BorderSide.none,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                label: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkmode ? Colors.white : mainBlue,
                                    fontFamily: 'OpenSansHebrew',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                // Al confirmar, ejecuta onConfirm si no está loading.
                                onPressed: loading ? null : onConfirm,
                                icon: const Icon(
                                  PhosphorIconsBold.check,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Sí, Cerrar Sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'OpenSansHebrew',
                                    fontSize: 16,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainBlue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Indicador visual de carga si loading es true.
                if (loading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withAlpha(64), // 0.25*255=64
                      child: Center(
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: CircularProgressIndicator(
                            color: mainBlue,
                            strokeWidth: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}