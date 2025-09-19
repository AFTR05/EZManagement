import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

/// Widget que muestra el encabezado del perfil de usuario.
///
/// Incluye el avatar circular con imagen y el nombre del usuario en texto.
/// El color del texto se recibe como parámetro para adaptar a temas.
class ProfileHeader extends StatelessWidget {
  /// Color utilizado para el texto del nombre.
  final Color textColor;

  /// Constructor de ProfileHeader, requiere el color de texto.
  const ProfileHeader({
    super.key,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Avatar circular con imagen fija y fondo semitransparente.
          CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
            backgroundColor: EZColorsApp.ezAppColor.withAlpha(38), // 0.15 * 255 ≈ 38
          ),
          const SizedBox(height: 12),
          // Nombre del usuario con estilo personalizado.
          Text(
            'Maria Celeste',
            style: TextStyle(
              fontFamily: 'OpenSansHebrew',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
