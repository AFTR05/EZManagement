import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    final mainBlue = EZColorsApp.ezAppColor;

    return AlertDialog(
      title: const Text('Eliminar Cuenta'),
      content: const Text(
        '¿Seguro que quieres eliminar tu cuenta? Esta acción no se puede deshacer.',
      ),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.pop(context, false),
          icon: Icon(
            PhosphorIconsBold.x,
            color: isDarkmode ? Colors.white : mainBlue,
          ),
          style: TextButton.styleFrom(
            backgroundColor: mainBlue.withValues(alpha: 0.20),
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
