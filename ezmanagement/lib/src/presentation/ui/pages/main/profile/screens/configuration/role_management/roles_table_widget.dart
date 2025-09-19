import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/core/utils/string_utils.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/domain/entities/ui/role_item_entity.dart';
import 'package:ezmanagement/src/domain/entities/user_entity.dart';
import 'package:ezmanagement/src/domain/enum/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RolesTableWidget extends StatelessWidget {
  final List<RoleItemEntity> roles;
  final void Function(RoleEntity role) onEdit;
  final void Function(BuildContext context, RoleEntity role) onMore;

  final Color cardBg;
  final Color brand;
  final Color borderColor;
  final Color dividerColor;
  final Color textPrimary;
  final Color textMuted;
  final Color scaffoldBg;

  const RolesTableWidget({
    super.key,
    required this.roles,
    required this.onEdit,
    required this.onMore,
    required this.cardBg,
    required this.brand,
    required this.borderColor,
    required this.dividerColor,
    required this.textPrimary,
    required this.textMuted,
    required this.scaffoldBg,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: brand,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(14),
                // Si no hay roles, redondear también la parte inferior
                bottom: roles.isEmpty ? const Radius.circular(14) : Radius.zero,
              ),
              border: Border.all(color: borderColor),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Roles',
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Asignados',
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Acciones',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contenido - Solo mostrar si hay roles
          if (roles.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(14),
                  ),
                  // borde solo de la tabla
                  border: Border.all(color: borderColor, width: 1),
                  color: cardBg,
                ),
                child: ListView.separated(
                  shrinkWrap: true, // <- toma solo el alto necesario
                  physics:
                      const NeverScrollableScrollPhysics(), // sin scroll interno
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ), // aire para la última fila
                  itemCount: roles.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, thickness: 1, color: dividerColor),
                  itemBuilder: (context, i) {
                    final roleItem = roles[i];
                    return _RoleRow(
                      roleItem: roleItem,
                      textColor: textPrimary,
                      mutedColor: textMuted,
                      borderOnAvatar: scaffoldBg,
                      onEdit: () => onEdit(roleItem.role),
                      onMore: () => onMore(context, roleItem.role),
                    );
                  },
                ),
              ),
            ),

          // Estado vacío - Mostrar solo si no hay roles
          if (roles.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_outlined, size: 64, color: textMuted),
                  const SizedBox(height: 16),
                  Text(
                    'No hay roles disponibles',
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Crea tu primer rol para comenzar a gestionar permisos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: textMuted,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _RoleRow extends StatelessWidget {
  final RoleItemEntity roleItem;
  final VoidCallback onEdit;
  final VoidCallback onMore;
  final Color textColor;
  final Color mutedColor;
  final Color borderOnAvatar;

  const _RoleRow({
    required this.roleItem,
    required this.onEdit,
    required this.onMore,
    required this.textColor,
    required this.mutedColor,
    required this.borderOnAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: "OpenSansHebrew",
      color: textColor,
      fontSize: 13,
      height: 1.25,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Nombre del rol
          Expanded(
            flex: 2,
            child: Text(roleItem.role.roleName, style: textStyle),
          ),

          // Avatares
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _AvatarGroup(
                users: roleItem.users,
                maxVisible: 4,
                borderColor: borderOnAvatar,
              ),
            ),
          ),

          // Acciones
          const SizedBox(width: 4),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _IconButtonCircle(
                  iconAsset: "assets/images/icons/edit_icon.svg",
                  tooltip: 'Editar',
                  onTap: onEdit,
                ),
                const SizedBox(width: 8),
                _IconButtonCircle(
                  iconAsset: "assets/images/icons/menu_that_icon.svg",
                  tooltip: 'Más',
                  onTap: onMore,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> usersInitials({required List<UserEntity> users}) {
    return users.map((u) {
      final raw = (u.name ?? '').trim();
      if (raw.isEmpty) return '—';

      final parts = raw
          .split(RegExp(r'\s+'))
          .where((p) => p.isNotEmpty)
          .toList();
      if (parts.isEmpty) return '—';

      final first = parts.first.characters.isNotEmpty
          ? parts.first.characters.first
          : '';
      final last = parts.length > 1 && parts.last.characters.isNotEmpty
          ? parts.last.characters.first
          : '';

      final initials = (first + last).toUpperCase();
      return initials.isNotEmpty ? initials : '—';
    }).toList();
  }
}

class _IconButtonCircle extends StatelessWidget {
  final String iconAsset;
  final String tooltip;
  final VoidCallback onTap;

  const _IconButtonCircle({
    required this.iconAsset,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          iconAsset,
          width: 25,
          height: 25,
          colorFilter: const ColorFilter.mode(
            EZColorsApp.greyColorIcon,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _AvatarGroup extends StatelessWidget {
  final List<UserEntity> users;
  final int maxVisible;
  final Color borderColor;
  const _AvatarGroup({
    required this.users,
    this.maxVisible = 4,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Text(
        '—',
        style: TextStyle(
          color: EZColorsApp.grayColor,
          fontFamily: "OpenSansHebrew",
        ),
      );
    }

    final visible = users.take(maxVisible).toList();
    final remaining = users.length - visible.length;

    return SizedBox(
      height: 32,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * 22.0,
              child: _CircleAvatarLabel(
                label: visible[i].name?.firstLastInitials ?? "",
                index: i,
                borderColor: borderColor,
                isDeactivated: visible[i].status == StateEnum.inactive,
              ),
            ),
          if (remaining > 0)
            Positioned(
              left: visible.length * 22.0,
              child: _CircleCounter(count: remaining, borderColor: borderColor),
            ),
        ],
      ),
    );
  }
}

class _CircleAvatarLabel extends StatelessWidget {
  final String label;
  final int index;
  final Color borderColor;
  final bool isDeactivated;

  const _CircleAvatarLabel({
    required this.label,
    required this.index,
    required this.borderColor,
    this.isDeactivated = false
  });

  @override
  Widget build(BuildContext context) {
    final palette = <Color>[
      Colors.orange,
      Colors.purple,
      Colors.green,
      Colors.red,
      Colors.blue,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    final bg = palette[index % palette.length];

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isDeactivated ? bg.withValues(alpha: 0.2) : bg,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        label.isNotEmpty ? label.characters.first.toUpperCase() : '',
        style: const TextStyle(
          fontFamily: "OpenSansHebrew",
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _CircleCounter extends StatelessWidget {
  final int count;
  final Color borderColor;
  const _CircleCounter({required this.count, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        '+$count',
        style: const TextStyle(
          fontFamily: "OpenSansHebrew",
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}
