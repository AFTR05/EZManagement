import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double screenWidth = size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          Positioned(
            top: -168.5,
            left: -121.5,
            child: ClipOval(
              child: Container(
                width: 243,
                height: 337,
                color: EZColorsApp.blueOcean,
              ),
            ),
          ),
          Positioned(
            top: -74,
            child: ClipOval(
              child: Container(
                width: 300,
                height: 148,
                color: EZColorsApp.ezAppColor,
              ),
            ),
          ),
          // Parte inferior decorativa
          Positioned(
            bottom: -168.5, // negativo para que sobresalga del borde
            right: -121.5,
            child: ClipOval(
              child: Container(
                width: 243,
                height: 337,
                color: EZColorsApp.blueOcean,
              ),
            ),
          ),
          Positioned(
            bottom: -74,
            right: 0,
            child: ClipOval(
              child: Container(
                width: 300,
                height: 148,
                color: EZColorsApp.ezAppColor,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      const Text(
                        'Inicio de sesión',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 60),

                      // User field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                          ),
                          border: const Border(
                            top: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.5,
                            ),
                            right: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.25,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                            hintText: 'Usuario',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(),
                          border: const Border(
                            top: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.25,
                            ),
                            right: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: .25,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                            hintText: 'Usuario',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                          ),
                          border: const Border(
                            top: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.25,
                            ),
                            right: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: EZColorsApp.lightGray,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                            hintText: 'Usuario',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1976D2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1976D2),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                              spreadRadius: -8,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/ez_solutions_logo.svg',
                          width: screenWidth < 600 ? 150 : 200,
                          height: screenWidth < 600 ? 150 : 200,
                          colorFilter: ColorFilter.mode(
                            EZColorsApp.ezAppColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
