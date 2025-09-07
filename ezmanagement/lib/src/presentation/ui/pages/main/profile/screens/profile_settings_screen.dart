//.withValues(alpha:
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/dialogs/delete_account_dialog.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/widgets/theme_switch_button.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool isLoading = false;

  Future<void> _showDeleteDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteAccountDialog(),
    );

    if (confirmed == true) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cuenta eliminada correctamente.'),
            duration: Duration(milliseconds: 1500),
          ),
        );

        await Future.delayed(const Duration(milliseconds: 1500));

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
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    final mainBlue = EZColorsApp.ezAppColor;
    final bgColor = isDarkmode ? EZColorsApp.darkBackgroud : Colors.white;
    final shadowColor = isDarkmode
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: .09);
    final cardColor = isDarkmode ? EZColorsApp.darkGray : Colors.white;

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
                style: TextStyle(
                  fontFamily: 'OpenSansHebrew',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                PhosphorIconsBold.caretRight,
                color: mainBlue.withValues(alpha: 0.6),
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
      appBar: CustomAppBarWidget(title: "Configuracion"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSettingsButton(
                  label: "Administrador De Contraseñas",
                  iconAsset: 'assets/images/icons/key_icon.svg',
                  onTap: () =>
                      Navigator.pushNamed(context, '/password-manager'),
                ),
                buildSettingsButton(
                  label: "Eliminar Cuenta",
                  iconAsset: 'assets/images/icons/user_icon.svg',
                  onTap: () => _showDeleteDialog(context),
                  isDestructive: true,
                ),
                ThemeSwitchButton(),
                buildSettingsButton(
                  label: "Gestionar Roles",
                  iconAsset: 'assets/images/icons/role_icon.svg',
                  onTap: () => Navigator.of(context).popAndPushNamed(RoutesApp.configRoles),
                  isDestructive: true,
                ),
                buildSettingsButton(
                  label: "Gestionar Usuarios",
                  iconAsset: 'assets/images/icons/users_icon.svg',
                  onTap: () => Navigator.pushNamed(context, '/users'),
                  isDestructive: true,
                ),
              ],
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.4),
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
