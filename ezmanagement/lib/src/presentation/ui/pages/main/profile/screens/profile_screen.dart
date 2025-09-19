import 'package:ezmanagement/src/presentation/ui/pages/main/profile/widgets/profile_header.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

/// [ProfileScreen] representa la pantalla principal de perfil de usuario.
///
/// Muestra el encabezado del perfil y el menú de opciones,
/// adaptando su color y estilo según el tema oscuro/claro.
class ProfileScreen extends StatelessWidget {
  /// Constructor de ProfileScreen.
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detecta si el modo oscuro está activo.
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define el color de fondo de la pantalla según el modo.
    final backgroundColor =
        isDark ? EZColorsApp.darkBackgroud : Colors.white;
    // Define el color para el título según el modo.
    final titleColor =
        isDark ? EZColorsApp.ezAppColor : EZColorsApp.blueOcean;
    // Define el color para los textos según el modo.
    final textColor = isDark ? Colors.white : Colors.black87;

    // Estructura principal de la pantalla: Scaffold con AppBar y cuerpo.
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        // Título de la pantalla de perfil.
        title: Text(
          'Mi Perfil',
          style: TextStyle(
            fontFamily: 'OpenSansHebrew',
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      // Contenido del cuerpo: encabezado y menú de perfil.
      body: Column(
        children: [
          // Encabezado del perfil: foto, datos, etc.
          ProfileHeader(
            textColor: textColor,
          ),
          // Menú de opciones de perfil.
          ProfileMenu(
            textColor: textColor,
            iconColor: EZColorsApp.blueOcean,
          ),
        ],
      ),
    );
  }
}