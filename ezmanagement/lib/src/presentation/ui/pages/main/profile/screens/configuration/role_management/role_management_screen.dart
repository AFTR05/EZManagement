import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/configuration/role_management/roles_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoleManagementScreen extends StatelessWidget {
  const RoleManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brand = EZColorsApp.ezAppColor;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final borderColor = EZColorsApp.ezAppColor;
    final dividerColor = EZColorsApp.ezAppColor;
    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: CustomAppBarWidget(title: "Gestión de roles"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Roles',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSansHebrew",
                  ),
                ),
                const Spacer(),
                _AddRoleButton(
                  onPressed: () {
                    // TODO: acción agregar rol
                  },
                  brand: brand,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tabla
            Expanded(
              child: RolesTableWidget(
                roles: _mockRoles,
                cardBg: scaffoldBg,
                brand: brand,
                borderColor: borderColor,
                dividerColor: dividerColor,
                textPrimary: textPrimary,
                textMuted: textPrimary,
                scaffoldBg: scaffoldBg,
                onEdit: (role) {
                  // TODO: acción editar rol
                },
                onMore: (ctx, role) => _showMoreOptions(ctx, role),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddRoleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color brand;
  const _AddRoleButton({required this.onPressed, required this.brand});

  @override
  Widget build(BuildContext context) {
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
            'Agregar rol',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? EZColorsApp.darkBackgroud
                  : Colors.white,
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
              Theme.of(context).brightness == Brightness.dark
                  ? EZColorsApp.darkBackgroud
                  : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}

class RoleItem {
  final String name;
  final List<String> assignees;
  RoleItem({required this.name, required this.assignees});
}

final _mockRoles = <RoleItem>[
  RoleItem(name: 'God of\nGoods', assignees: ['A', 'B', 'C']),
  RoleItem(name: 'God of\nKnowledge', assignees: []),
  RoleItem(name: 'God of\nStorytelling', assignees: ['M', 'K']),
  RoleItem(name: 'God of\nSupport', assignees: []),
  RoleItem(name: 'God of\nAdventure', assignees: ['R', 'P', 'X']),
  RoleItem(name: 'Shiny\nHunter', assignees: ['H', 'U', 'V', 'W']),
  RoleItem(name: 'Contest\nCoordinator', assignees: ['C', 'D', 'E', 'F']),
  RoleItem(name: 'Shiny\nPokemons', assignees: ['S', 'H', 'N', 'Q']),
  RoleItem(name: 'Evolution\nExpert', assignees: []),
];

void _showMoreOptions(BuildContext context, RoleItem role) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text('Editar ${role.name.replaceAll('\n', ' ')}'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person_add_outlined),
              title: const Text('Asignar usuarios'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: EZColorsApp.ezAppColor,
              ),
              title: Text(
                'Eliminar ${role.name.replaceAll('\n', ' ')}',
                style: TextStyle(
                  fontFamily: "OpenSansHebrew",
                  color: EZColorsApp.ezAppColor,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    ),
  );
}
