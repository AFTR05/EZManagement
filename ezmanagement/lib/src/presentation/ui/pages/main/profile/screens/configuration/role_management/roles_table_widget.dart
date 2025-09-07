import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/configuration/role_management/role_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RolesTableWidget extends StatelessWidget {
  final List<RoleItem> roles;
  final void Function(RoleItem role) onEdit;
  final void Function(BuildContext context, RoleItem role) onMore;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: brand,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
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
          Expanded(
            child: ListView.separated(
              itemCount: roles.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, thickness: 1, color: dividerColor),
              itemBuilder: (context, i) {
                final role = roles[i];
                return _RoleRow(
                  role: role,
                  textColor: textPrimary,
                  mutedColor: textMuted,
                  borderOnAvatar: scaffoldBg,
                  onEdit: () => onEdit(role),
                  onMore: () => onMore(context, role),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleRow extends StatelessWidget {
  final RoleItem role;
  final VoidCallback onEdit;
  final VoidCallback onMore;
  final Color textColor;
  final Color mutedColor;
  final Color borderOnAvatar;

  const _RoleRow({
    required this.role,
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
          Expanded(flex: 2, child: Text(role.name, style: textStyle)),

          // Avatares
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _AvatarGroup(
                initials: role.assignees,
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
  final List<String> initials;
  final int maxVisible;
  final Color borderColor;
  const _AvatarGroup({
    required this.initials,
    this.maxVisible = 4,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    if (initials.isEmpty) {
      return Text(
        '—',
        style: TextStyle(
          color: EZColorsApp.grayColor,
          fontFamily: "OpenSansHebrew",
        ),
      );
    }

    final visible = initials.take(maxVisible).toList();
    final remaining = initials.length - visible.length;

    return SizedBox(
      height: 32,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * 22.0,
              child: _CircleAvatarLabel(
                label: visible[i],
                index: i,
                borderColor: borderColor,
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

  const _CircleAvatarLabel({
    required this.label,
    required this.index,
    required this.borderColor,
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
        color: bg,
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
