import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

/// [DeleteAccountDialog] muestra una ventana emergente (AlertDialog)
/// para la confirmación de eliminación de cuenta.
///
/// Presenta un título, mensaje de advertencia y dos botones de acción:
/// "Cancelar" y "Sí, eliminar". Ambos devuelven un valor (false o true)
/// al cerrar el diálogo.
class DeleteAccountDialog extends StatelessWidget {
  /// Constructor de DeleteAccountDialog.
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Detecta si el tema actual es oscuro.
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    // Valor principal azul definido en EZColorsApp.
    final mainBlue = EZColorsApp.ezAppColor;

    // Construcción de la ventana de diálogo con título, contenido y acciones.
    return AlertDialog(
      // Título del diálogo.
      title: const Text('Eliminar Cuenta'),
      // Mensaje principal de advertencia.
      content: const Text(
        '¿Seguro que quieres eliminar tu cuenta? Esta acción no se puede deshacer.',
      ),
      // Botones de acción: Cancelar y Sí, eliminar.
      actions: [
        TextButton.icon(
          // Cierra el diálogo, devuelve false al llamar Navigator.pop.
          onPressed: () => Navigator.pop(context, false),
          icon: Icon(
            PhosphorIconsBold.x,
            color: isDarkmode ? Colors.white : mainBlue,
          ),
          style: TextButton.styleFrom(
            // Fondo semitransparente.
            backgroundColor: mainBlue.withAlpha(51), // 0.20*255=51
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          label: Text(
            'Cancelar',
            style: TextStyle(
              color: isDarkmode ? Colors.white : mainBlue,
            ),
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          // Cierra el diálogo, devuelve true.
          onPressed: () => Navigator.pop(context, true),
          icon: const Icon(
            PhosphorIconsBold.check,
            color: Colors.white,
          ),
          label: const Text(
            'Sí, eliminar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}