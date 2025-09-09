import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brand = EZColorsApp.ezAppColor;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final borderColor = EZColorsApp.ezAppColor;
    final dividerColor = EZColorsApp.ezAppColor;
    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;
    final fontFamily = "OpenSansHebrew";

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: CustomAppBarWidget(title: "Gestion de usuarios"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: EZColorsApp.ezAppColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  hintStyle: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.w200,
                    fontFamily: fontFamily,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // Filtro de ordenamiento
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Ordenar Por',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 14,
                    fontFamily: fontFamily,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: EZColorsApp.ezAppColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'A → Z',
                    style: TextStyle(
                      color: EZColorsApp.ezAppColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Lista de usuarios
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildUserCard(
                  context: context,
                  name: 'Diego Posada',
                  role: 'Administrador',
                  avatar: 'assets/images/diego.jpg', // Reemplaza con tu asset
                ),
                const SizedBox(height: 12),
                _buildUserCard(
                  context: context,
                  name: 'Juan Andrés Posada',
                  role: 'Empleado',
                  avatar: 'assets/images/juan.jpg', // Reemplaza con tu asset
                ),
                const SizedBox(height: 12),
                _buildUserCard(
                  context: context,
                  name: 'Andrés Toro',
                  role: 'Administrador',
                  avatar: 'assets/images/andres.jpg', // Reemplaza con tu asset
                ),
                const SizedBox(height: 12),
                _buildUserCard(
                  context: context,
                  name: 'Ana Milena Alcans',
                  role: 'Empleado',
                  avatar: 'assets/images/ana.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard({
    required BuildContext context,
    required String name,
    required String role,
    required String avatar,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brand = EZColorsApp.ezAppColor;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final borderColor = EZColorsApp.ezAppColor;
    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;
    final iconColor = isDark ? EZColorsApp.lightGray : EZColorsApp.grayColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scaffoldBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        children: [
          // Avatar del usuario
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? EZColorsApp.darkGray : Colors.grey[300],
              // Si tienes las imágenes, usa:
              // image: DecorationImage(
              //   image: AssetImage(avatar),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Icon(Icons.person, color: iconColor, size: 30),
          ),

          const SizedBox(width: 16),

          // Información del usuario
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: brand,
                    fontFamily: "OpenSansHebrew",
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 14,
                    color: textPrimary.withOpacity(0.7),
                    fontFamily: "OpenSansHebrew",
                  ),
                ),
                const SizedBox(height: 8),
                // Botón Info
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para ver información
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brand,
                      foregroundColor: isDark
                          ? EZColorsApp.darkBackgroud
                          : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Text(
                      'Info',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "OpenSansHebrew",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Botones de acción
          Column(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/images/icons/edit_icon.svg",
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    EZColorsApp.ezAppColor,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  // Acción para editar usuario
                },
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
              const SizedBox(height: 8),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/images/icons/delete_icon.svg",
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    EZColorsApp.ezAppColor,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  _showDeleteDialog(context, name, brand, textPrimary, isDark);
                },
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    String userName,
    Color brand,
    Color textPrimary,
    bool isDark,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? EZColorsApp.darkBackgroud : Colors.white,
          title: Text(
            'Eliminar usuario',
            style: TextStyle(
              color: textPrimary,
              fontFamily: "OpenSansHebrew",
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            '¿Estás seguro de que deseas eliminar a $userName?',
            style: TextStyle(color: textPrimary, fontFamily: "OpenSansHebrew"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: textPrimary,
                  fontFamily: "OpenSansHebrew",
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: implementar eliminación
              },
              child: Text(
                'Eliminar',
                style: TextStyle(
                  color: brand,
                  fontFamily: "OpenSansHebrew",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AddUserButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color brand;
  const _AddUserButton({required this.onPressed, required this.brand});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: brand,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Agregar usuario',
            style: TextStyle(
              color: isDark ? EZColorsApp.darkBackgroud : Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSansHebrew",
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            "assets/images/icons/add_icon.svg",
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(
              isDark ? EZColorsApp.darkBackgroud : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
