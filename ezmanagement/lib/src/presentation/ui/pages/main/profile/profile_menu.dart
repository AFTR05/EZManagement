import 'package:easy_localization/easy_localization.dart';
import 'package:ezmanagement/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class ProfileMenuItem {
  final String label;
  final IconData? icon;
  final String? iconAsset;
  final String? route;
  final bool isLogout;
  const ProfileMenuItem({
    required this.label,
    this.icon,
    this.iconAsset,
    this.route,
    this.isLogout = false,
  });
}

class ProfileMenuTile extends StatelessWidget {
  final ProfileMenuItem item;
  final Color textColor;
  final Color iconColor;

  const ProfileMenuTile({
    super.key,
    required this.item,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: iconColor.withValues(alpha: 0.15),
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
      trailing: item.isLogout
          ? null
          : Icon(
              PhosphorIconsBold.caretRight,
              color: EZColorsApp.blueOcean.withValues(alpha: 0.6),
              size: 20,
            ),
      onTap: () {
        if (item.route != null) {
          Navigator.pushNamed(context, item.route!);
        }
        if (item.isLogout) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(LocaleKeys.profileMenuLoggingOutSnack.tr())),
          );
        }
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final Color textColor;
  final Color iconColor;

  const ProfileMenu({
    super.key,
    required this.textColor,
    required this.iconColor,
  });

  List<ProfileMenuItem> get menuItems => [
    ProfileMenuItem(
      label: LocaleKeys.profileLabel.tr(),
      iconAsset: 'assets/images/icons/user_icon.svg',
      route: '/edit-profile',
    ),
    ProfileMenuItem(
      label: LocaleKeys.profileMenuFavoritesLabel.tr(),
      icon: PhosphorIconsBold.heart,
      route: '/favorites',
    ),
    ProfileMenuItem(
      label: LocaleKeys.profileMenuPrivacyPolicyLabel.tr(),
      iconAsset: 'assets/images/icons/password_icon.svg',
      route: '/privacy-policy',
    ),
    ProfileMenuItem(
      label: LocaleKeys.profileMenuSettingsLabel.tr(),
      icon: PhosphorIconsBold.gear,
      route: '/settings',
    ),
    ProfileMenuItem(
      label: LocaleKeys.profileMenuLogoutLabel.tr(),
      icon: PhosphorIconsBold.signOut,
      isLogout: true,
      route: '/logout',
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
