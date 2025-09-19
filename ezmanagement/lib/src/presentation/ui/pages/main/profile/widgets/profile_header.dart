import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileHeader extends ConsumerWidget {
  final Color textColor;

  const ProfileHeader({super.key, required this.textColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Capturamos el future una sola vez por build
    final futureName = ref.read(authenticationControllerProvider).getUserName();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: EZColorsApp.ezAppColor.withValues(alpha: 0.15),
            child: Icon(Icons.person, color: EZColorsApp.ezAppColor, size: 80),
          ),
          const SizedBox(height: 12),
          FutureBuilder<String>(
            future: futureName,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Text(
                  '', // o 'Cargando...'
                  style: TextStyle(
                    fontFamily: 'OpenSansHebrew',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor,
                  ),
                );
              }
              if (snap.hasError) {
                // evita mostrar excepción al usuario; puedes loggear aparte
                return Text(
                  '',
                  style: TextStyle(
                    fontFamily: 'OpenSansHebrew',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor,
                  ),
                );
              }
              final name = (snap.data ?? '').trim();
              return Text(
                name,
                style: TextStyle(
                  fontFamily: 'OpenSansHebrew',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: textColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}