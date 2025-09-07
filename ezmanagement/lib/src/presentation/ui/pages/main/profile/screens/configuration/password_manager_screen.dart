import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class PasswordManagerScreen extends StatefulWidget {
  const PasswordManagerScreen({super.key});

  @override
  State<PasswordManagerScreen> createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    final mainBlue = EZColorsApp.ezAppColor;
    final bgColor = isDarkmode ? EZColorsApp.darkBackgroud : Colors.white;
    final inputBg = mainBlue.withValues(alpha: 0.07);
    final textColor = isDarkmode ? Colors.white : Colors.black87;
    final borderRadius = BorderRadius.circular(12.0);

    Widget buildPasswordField({
      required String label,
      required TextEditingController controller,
      required bool obscure,
      required VoidCallback onToggle,
      bool isFirst = false,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: isFirst ? 16 : 22, bottom: 7),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'OpenSansHebrew',
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: !obscure,
            style: TextStyle(
              fontFamily: 'OpenSansHebrew',
              fontSize: 17,
              color: mainBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: inputBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscure ? PhosphorIconsRegular.eye : PhosphorIconsRegular.eyeSlash,
                  color: mainBlue,
                  size: 22,
                ),
                onPressed: onToggle,
              ),
            ),
          ),
        ],
      );
    }

    

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBarWidget(title: "Administrador de contraseñas"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            buildPasswordField(
              label: "Contraseña Actual",
              controller: currentController,
              obscure: _showCurrent,
              onToggle: () => setState(() => _showCurrent = !_showCurrent),
              isFirst: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: GestureDetector(
                onTap: () {
                
                },
                child: Text(
                  "¿Olvidaste Tu Contraseña?",
                  style: TextStyle(
                    color: mainBlue,
                    fontFamily: 'OpenSansHebrew',
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            buildPasswordField(
              label: "Nueva Contraseña",
              controller: newController,
              obscure: _showNew,
              onToggle: () => setState(() => _showNew = !_showNew),
            ),
            buildPasswordField(
              label: "Confirmar Nueva Contraseña",
              controller: confirmController,
              obscure: _showConfirm,
              onToggle: () => setState(() => _showConfirm = !_showConfirm),
            ),
            const SizedBox(height: 38),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainBlue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                ),
                onPressed: () {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cambio de contraseña realizado'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  "Cambiar Contraseña",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSansHebrew',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
