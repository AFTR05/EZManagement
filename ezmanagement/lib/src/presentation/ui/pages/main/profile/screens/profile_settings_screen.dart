//.withValues(alpha:
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/dialogs/delete_account_dialog.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/widgets/theme_switch_button.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

/// Pantalla de configuración del perfil.
///
/// Permite al usuario gestionar opciones como administrador de contraseñas,
/// eliminación de cuenta, cambio de tema y gestión de roles y usuarios.
///
/// Maneja estado de carga para mostrar indicador mientras se procesa eliminación.
class ProfileSettingsScreen extends StatefulWidget {
  /// Constructor de ProfileSettingsScreen.
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  /// Estado que indica si hay una operación en carga.
  bool isLoading = false;

  /// Muestra el diálogo para confirmar eliminación de cuenta.
  ///
  /// Si el usuario confirma, simula proceso de eliminación con retraso
  /// y luego navega al login eliminando historial de rutas.
  Future<void> _showDeleteDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteAccountDialog(),
    );

    // Si el usuario confirma la eliminación
    if (confirmed == true) {
      setState(() {
        isLoading = true; // Activa indicador de carga
      });

      // Simula procesamiento (1 segundo)
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLoading = false; // Desactiva indicador de carga
      });

      if (mounted) {
        // Muestra mensaje breve de confirmación
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cuenta eliminada correctamente.'),
            duration: Duration(milliseconds: 1500),
          ),
        );

        // Espera para que usuario lea el mensaje
        await Future.delayed(const Duration(milliseconds: 1500));

        // Navega a pantalla de login eliminando historial
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detecta si el tema es oscuro
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    // Color principal azul de la app
    final mainBlue = EZColorsApp.ezAppColor;
    // Color de fondo según tema
    final bgColor = isDarkmode ? EZColorsApp.darkBackgroud : Colors.white;
    // Color para sombras según tema
    final shadowColor = isDarkmode
        ? Colors.black.withAlpha((0.3 * 255).toInt())
        : Colors.black.withAlpha((0.09 * 255).toInt());
    // Color para tarjetas según tema
    final cardColor = isDarkmode ? EZColorsApp.darkGray : Colors.white;

    /// Construye un botón personalizado para las opciones de configuración.
    ///
    /// Parámetros:
    /// - [label]: texto que describe la opción.
    /// - [iconAsset]: ruta del icono SVG.
    /// - [onTap]: función que se ejecuta al pulsar el botón.
    /// - [isDestructive]: indica si la acción es potencialmente destructiva (no afecta acá el comportamiento).
    Widget buildSettingsButton({
      required String label,
      required String iconAsset,
      required VoidCallback onTap,
      bool isDestructive = false,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 15,
                offset: const Offset(1, 1),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Material(
            elevation: 2,
            shadowColor: shadowColor,
            borderRadius: BorderRadius.circular(10),
            color: cardColor,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: cardColor,
              leading: SvgPicture.asset(iconAsset, width: 21, height: 21),
              title: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'OpenSansHebrew',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                PhosphorIconsBold.caretRight,
                color: mainBlue.withAlpha((0.6 * 255).toInt()),
                size: 20,
              ),
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: const CustomAppBarWidget(title: "Configuracion"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botón para ir al administrador de contraseñas
                buildSettingsButton(
                  label: "Administrador De Contraseñas",
                  iconAsset: 'assets/images/icons/key_icon.svg',
                  onTap: () => Navigator.pushNamed(context, '/password-manager'),
                ),
                // Botón para eliminar cuenta con diálogo de confirmación
                buildSettingsButton(
                  label: "Eliminar Cuenta",
                  iconAsset: 'assets/images/icons/user_icon.svg',
                  onTap: () => _showDeleteDialog(context),
                  isDestructive: true,
                ),
                // Botón para cambiar tema con interruptor
                const ThemeSwitchButton(),
                // Botón para gestionar roles
                buildSettingsButton(
                  label: "Gestionar Roles",
                  iconAsset: 'assets/images/icons/role_icon.svg',
                  onTap: () => Navigator.of(context).pushNamed(RoutesApp.configRoles),
                  isDestructive: true,
                ),
                // Botón para gestionar usuarios
                buildSettingsButton(
                  label: "Gestionar Usuarios",
                  iconAsset: 'assets/images/icons/users_icon.svg',
                  onTap: () => Navigator.of(context).pushNamed(RoutesApp.configUsers),
                  isDestructive: true,
                ),
              ],
            ),
          ),
          // Indicador de carga sobre la pantalla mientras isLoading es true
          if (isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: ColoredBox(
                  color: Colors.black.withAlpha((0.4 * 255).toInt()),
                  child: Center(
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: EZColorsApp.ezAppColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}