import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Responsive font: base size -> scaled by shortestSide and textScaleFactor.
  double _rf(BuildContext context, double base,
      {double min = 12, double max = 34}) {
    final size = MediaQuery.of(context).size;
    final shortest = size.shortestSide;
    // Escala suave (375 = base iPhone 11/12/13)
    final geomScale = (shortest / 375).clamp(0.85, 1.35);
    final sysScale = MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.4);
    final v = base * geomScale * sysScale;
    return v.clamp(min, max).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, screenHeight),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? EZColorsApp.darkBackgroud
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gestión Principal',
                        style: TextStyle(
                          fontSize: _rf(context, 22, min: 16, max: 28),
                          fontFamily: 'OpenSansHebrew',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : EZColorsApp.darkColorText,
                        ),
                      ),
                      const SizedBox(height: 25),
                      _buildMenuGrid(context),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: screenHeight * 0.06,
        left: 30,
        right: 30,
        bottom: screenHeight * 0.08,
      ),
      decoration: BoxDecoration(
        color: EZColorsApp.ezAppColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: EZColorsApp.ezAppColor.withValues(alpha: .3),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // título
          Text(
            'Hola, Juan',
            style: TextStyle(
              color: Colors.white,
              fontSize: _rf(context, 28, min: 20, max: 34),
              fontFamily: 'OpenSansHebrew',
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(
              'assets/images/ez_logo.svg',
              width: 60,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildEnhancedMenuButton(
                icon: PhosphorIconsFill.package,
                text: 'Productos',
                subtitle: 'Gestionar inventario',
                color: EZColorsApp.ezAppColor,
                context: context,
                onTap: () => debugPrint('Productos presionado'),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildEnhancedMenuButton(
                icon: Icons.assignment,
                text: 'Materiales',
                context: context,
                subtitle: 'Control de stock',
                color: EZColorsApp.ezAppColor,
                onTap: () => debugPrint('Materiales presionado'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildEnhancedMenuButton(
          icon: PhosphorIconsFill.chartBar,
          text: 'Registro de Ventas',
          context: context,
          subtitle: 'Análisis y reportes',
          color: EZColorsApp.ezAppColor,
          isFullWidth: true,
          onTap: () => debugPrint('Registro de Ventas presionado'),
        ),
      ],
    );
  }

  Widget _buildEnhancedMenuButton({
    required IconData icon,
    required String text,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required BuildContext context,
    bool isFullWidth = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isFullWidth ? double.infinity : null,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? EZColorsApp.darkBackgroud
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: .1), width: 1),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: .08),
                spreadRadius: 0,
                blurRadius:
                    Theme.of(context).brightness == Brightness.dark ? 0 : 15,
                offset: Offset(
                  0,
                  Theme.of(context).brightness == Brightness.dark ? 0 : 5,
                ),
              ),
            ],
          ),
          child: isFullWidth
              ? Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: 32),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: _rf(context, 18, min: 14, max: 22),
                              fontFamily: 'OpenSansHebrew',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : EZColorsApp.darkColorText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: _rf(context, 14, min: 12, max: 18),
                              fontFamily: 'OpenSansHebrew',
                              fontWeight: FontWeight.w400,
                              color: EZColorsApp.grayColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: EZColorsApp.grayColor, size: 16),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: color, size: 28),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: _rf(context, 16, min: 12, max: 20),
                        fontFamily: 'OpenSansHebrew',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : EZColorsApp.darkColorText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: _rf(context, 12, min: 10, max: 16),
                        fontFamily: 'OpenSansHebrew',
                        fontWeight: FontWeight.w400,
                        color: EZColorsApp.grayColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
