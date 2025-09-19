import 'package:easy_localization/easy_localization.dart';
import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:ezmanagement/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LogoutConfirmationDialog extends ConsumerWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    final mainBlue = EZColorsApp.ezAppColor;
    final bgColor = isDarkmode ? EZColorsApp.darkBackgroud : Colors.white;
    final textColor = isDarkmode ? Colors.white : Colors.black87;

    final ValueNotifier<bool> isLoading = ValueNotifier(false);

    Future<void> onConfirm() async {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      final logOutResult = await ref
          .read(authenticationControllerProvider)
          .logout();
      if (!context.mounted) return;
      if (logOutResult) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(RoutesApp.login, (route) => false);
        isLoading.value = false;
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(LocaleKeys.logoutError.tr())));
      }
    }

    return WillPopScope(
      onWillPop: () async => !isLoading.value,
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, loading, _) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Opacity(
                  opacity: loading ? 0.5 : 1,
                  child: AbsorbPointer(
                    absorbing: loading,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainBlue,
                            fontFamily: 'OpenSansHebrew',
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '¿Estás seguro de que deseas cerrar sesión?',
                          style: TextStyle(
                            fontFamily: 'OpenSansHebrew',
                            fontSize: 16,
                            color: textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: loading
                                    ? null
                                    : () => Navigator.pop(context, false),
                                icon: Icon(
                                  PhosphorIconsBold.x,
                                  color: isDarkmode ? Colors.white : mainBlue,
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: mainBlue.withValues(
                                    alpha: 0.20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide.none,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                label: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkmode ? Colors.white : mainBlue,
                                    fontFamily: 'OpenSansHebrew',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: loading ? null : onConfirm,
                                icon: const Icon(
                                  PhosphorIconsBold.check,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Sí, Cerrar Sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'OpenSansHebrew',
                                    fontSize: 16,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (loading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.25),
                      child: Center(
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: CircularProgressIndicator(
                            color: mainBlue,
                            strokeWidth: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}