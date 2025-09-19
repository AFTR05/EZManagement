import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';
import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  bool _sortAsc = true;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;
    final fontFamily = "OpenSansHebrew";

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: CustomAppBarWidget(
        title: "Gestion de usuarios",
        actions: [_AddUserButton(brand: EZColorsApp.ezAppColor)],
      ),
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
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => _sortAsc = !_sortAsc),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: EZColorsApp.ezAppColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _sortAsc ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 16,
                          color: EZColorsApp.ezAppColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _sortAsc ? 'A → Z' : 'Z → A',
                          style: TextStyle(
                            color: EZColorsApp.ezAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Lista de usuarios
          Expanded(
            child: StreamBuilder<List<UserEntity>>(
              stream: ref.read(userControllerProvider).watchAllElements(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error cargando usuarios'));
                }

                final users = snapshot.data ?? const <UserEntity>[];
                if (users.isEmpty) {
                  return const Center(child: Text('No hay usuarios'));
                }

                int cmpString(String? a, String? b) =>
                    (a ?? '').toLowerCase().compareTo((b ?? '').toLowerCase());

                final sorted = [...users]
                  ..sort((a, b) {
                    final cmp = cmpString(a.name, b.name);
                    return _sortAsc ? cmp : -cmp;
                  });
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: sorted.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final u = sorted[i];
                    return _buildUserCard(
                      context: context,
                      user: u,
                      name: (u.name?.isNotEmpty ?? false)
                          ? u.name!
                          : '(Sin nombre)',
                      role: (u.roleName?.isNotEmpty ?? false)
                          ? u.roleName!
                          : '—',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard({
    required BuildContext context,
    required UserEntity user,
    required String name,
    required String role,
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
                  color: Colors.grey.withValues(alpha: .1),
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
                    color: textPrimary.withValues(alpha: .7),
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
                  user.status == StateEnum.active
                      ? "assets/images/icons/delete_icon.svg"
                      : "assets/images/icons/reactivate_icon.svg",
                  width: user.status == StateEnum.active ? 20 : 25,
                  height: user.status == StateEnum.active ? 20 : 25,
                  colorFilter: ColorFilter.mode(
                    EZColorsApp.ezAppColor,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  _showDeleteDialog(
                    context,
                    name,
                    brand,
                    textPrimary,
                    isDark,
                    user,
                  );
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
    UserEntity user,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? EZColorsApp.darkBackgroud : Colors.white,
          title: Text(
            user.status == StateEnum.active ? 'Eliminar usuario' : "Reactivar",
            style: TextStyle(
              color: textPrimary,
              fontFamily: "OpenSansHebrew",
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            '¿Estás seguro de que deseas ${user.status == StateEnum.active ? "eliminar" : "reactivar"} a $userName?',
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
                ref
                    .read(userControllerProvider)
                    .deactivateActivateUser(
                      user: user,
                      isDeactivate: user.status == StateEnum.active,
                    );
                Navigator.of(
                  context,
                ).pop(RoutesApp.configUsers);
                // TODO: implementar eliminación
              },
              child: Text(
                user.status == StateEnum.active ? "Eliminar" : "Reactivar",
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
  final Color brand;
  const _AddUserButton({required this.brand});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pushNamed(RoutesApp.createUser),
      style: ElevatedButton.styleFrom(),
      icon: SvgPicture.asset(
        "assets/images/icons/add_icon.svg",
        width: 30,
        height: 25,
        colorFilter: ColorFilter.mode(EZColorsApp.ezAppColor, BlendMode.srcIn),
      ),
    );
  }
}
