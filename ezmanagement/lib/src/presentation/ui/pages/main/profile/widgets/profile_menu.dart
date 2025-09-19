import 'package:ezmanagement/src/presentation/ui/pages/main/profile/dialogs/logout_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

/// Modelo que representa un elemento individual del menú de perfil.
///
/// Contiene etiqueta, icono (u asset), ruta para navegación y bandera para logout.
class ProfileMenuItem {
  /// Texto que describe el ítem del menú.
  final String label;

  /// Icono de tipo [IconData] para mostrar en el menú (opcional).
  final IconData? icon;

  /// Ruta al asset de imagen o SVG para el icono (opcional).
  final String? iconAsset;

  /// Nombre de la ruta para navegación al pulsar el ítem (opcional).
  final String? route;

  /// Indicador si el ítem es para cerrar sesión.
  final bool isLogout;

  /// Constructor de ProfileMenuItem con parámetros opcionales.
  const ProfileMenuItem({
    required this.label,
    this.icon,
    this.iconAsset,
    this.route,
    this.isLogout = false,
  });
}

/// Widget con diseño para mostrar un ítem del menú de perfil.
///
/// Incluye icono o asset, texto y manejo de pulsación.
class ProfileMenuTile extends StatelessWidget {
  /// Elemento que contiene datos para mostrar.
  final ProfileMenuItem item;

  /// Color del texto mostrado.
  final Color textColor;

  /// Color del icono mostrado.
  final Color iconColor;

  /// Constructor con elementos requeridos.
  const ProfileMenuTile({
    super.key,
    required this.item,
    required this.textColor,
    required this.iconColor,
  });

  /// Muestra un modal para confirmar el cierre de sesión.
  ///
  /// Si se confirma, navega a la pantalla de login eliminando el historial.
  Future<void> _showLogoutBottomSheet(BuildContext context) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      barrierColor: EZColorsApp.ezAppColor.withAlpha(204), // 0.8 * 255 ≈ 204
      builder: (_) => const LogoutConfirmationDialog(),
    );

    if (confirmed == true) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: iconColor.withAlpha(38), // 0.15 * 255 ≈ 38
        // Muestra icono según asset SVG o imagen, o icono normal.
        child: item.iconAsset != null
            ? (item.iconAsset!.endsWith('.svg')
                ? SvgPicture.asset(
                    item.iconAsset!,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  )
                : Image.asset(
                    item.iconAsset!,
                    width: 22,
                    height: 22,
                    color: iconColor,
                  ))
            : Icon(item.icon, color: iconColor, size: 22),
      ),
      title: Text(
        item.label,
        style: TextStyle(
          fontFamily: 'OpenSansHebrew',
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      // Muestra icono de flecha si no es logout.
      trailing: item.isLogout
          ? null
          : Icon(
              PhosphorIconsBold.caretRight,
              color: EZColorsApp.blueOcean.withAlpha(153), // 0.6 * 255 ≈ 153
              size: 20,
            ),
      // Acción al pulsar el ítem: muestra diálogo logout o navega.
      onTap: () {
        if (item.isLogout) {
          _showLogoutBottomSheet(context);
        } else if (item.route != null) {
          Navigator.pushNamed(context, item.route!);
        }
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

/// Widget que construye la lista de ítems del menú de perfil.
///
/// Los colores de texto e icono se reciben como parámetros para temas.
class ProfileMenu extends StatelessWidget {
  /// Color del texto en elementos de menú.
  final Color textColor;

  /// Color del icono en elementos de menú.
  final Color iconColor;

  /// Constructor con parámetros obligatorios.
  const ProfileMenu({
    super.key,
    required this.textColor,
    required this.iconColor,
  });

  /// Lista estática de ítems que componen el menú.
  List<ProfileMenuItem> get menuItems => const [
        ProfileMenuItem(
          label: 'Perfil',
          iconAsset: 'assets/images/icons/user_icon.svg',
          route: '/edit-profile',
        ),
        ProfileMenuItem(
          label: 'Favoritos',
          icon: PhosphorIconsBold.heart,
          route: '/favorites',
        ),
        ProfileMenuItem(
          label: 'Política de Privacidad',
          iconAsset: 'assets/images/icons/password_icon.svg',
          route: '/privacy-policy',
        ),
        ProfileMenuItem(
          label: 'Configuración',
          icon: PhosphorIconsBold.gear,
          route: '/config',
        ),
        ProfileMenuItem(
          label: 'Cerrar Sesión',
          icon: PhosphorIconsBold.signOut,
          isLogout: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ProfileMenuTile(
          item: item,
          textColor: textColor,
          iconColor: iconColor,
        );
      },
    );
  }
}