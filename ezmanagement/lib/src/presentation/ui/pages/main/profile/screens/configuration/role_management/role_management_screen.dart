import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/configuration/role_management/roles_table_widget.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class RoleManagementScreen extends ConsumerWidget {
  const RoleManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brand = EZColorsApp.ezAppColor;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final borderColor = EZColorsApp.ezAppColor;
    final dividerColor = EZColorsApp.ezAppColor;
    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: CustomAppBarWidget(title: "Gestión de roles"),
      body: Center(
        child: Padding(
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
                      Navigator.of(context).pushNamed(RoutesApp.createRole);
                    },
                    brand: brand,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<List<RoleEntity>>(
                  stream: ref.read(roleControllerProvider).watchAllElements(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error cargando roles'));
                    }
                    final roles = snapshot.data ?? const <RoleEntity>[];
                    return RolesTableWidget(
                      roles: roles,
                      cardBg: scaffoldBg,
                      brand: brand,
                      borderColor: borderColor,
                      dividerColor: dividerColor,
                      textPrimary: textPrimary,
                      textMuted: textPrimary,
                      scaffoldBg: scaffoldBg,
                      onEdit: (role) {},
                      onMore: (ctx, role) => _showMoreOptions(ctx, role),
                    );
                  },
                ),
              ),
            ],
          ),
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

void _showMoreOptions(BuildContext context, RoleEntity role) {
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
              title: Text('Editar ${role.roleName.replaceAll('\n', ' ')}'),
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
                'Eliminar ${role.roleName.replaceAll('\n', ' ')}',
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
