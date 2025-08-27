import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/core/validators/fields_validators.dart';
import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/inputs/custom_auth_text_field_widget.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/logo/ez_logo_widget.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/backgrounds/user_background_decoration.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/buttons/custom_login_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _animationController;
  final _formKey = GlobalKey<FormState>();
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isSmallScreen = width < 400;
    final isMediumScreen = width >= 400 && width < 600;
    final isTablet = width >= 600;

    return Scaffold(
      body: Stack(
        children: [
          UserBackgroundDecorationWidget(width: width, height: height),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(width),
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: height - MediaQuery.of(context).padding.top - 40,
                    maxWidth: isTablet ? 450 : double.infinity,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.08),
                          _buildTitle(isSmallScreen),
                          SizedBox(height: height * 0.06),
                          _buildLoginForm(width, height, isSmallScreen),

                          SizedBox(height: height * 0.08),

                          EZLogoWidget(
                            width: width,
                            isSmallScreen: isSmallScreen,
                            isMediumScreen: isMediumScreen,
                          ),

                          SizedBox(height: height * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Inicio de sesión',
        style: TextStyle(
          fontSize: isSmallScreen ? 24 : 28,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          letterSpacing: 0.5,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLoginForm(double width, double height, bool isSmallScreen) {
    final formWidth = width > 600 ? 400.0 : width * 0.85;
    final borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : EZColorsApp.lightGray;

    return Align(
      alignment: isSmallScreen ? Alignment.centerLeft : Alignment.center,
      child: Container(
        width: isSmallScreen ? double.infinity : formWidth,
        padding: isSmallScreen ? const EdgeInsets.only(left: 0) : null,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: isSmallScreen ? 25 : 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: isSmallScreen
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    CustomAuthTextFieldWidget(
                      controller: _emailController,
                      validator: FieldsValidators.fieldIsRequired,
                      hintText: 'Usuario',
                      boxBorder: Border(
                        top: BorderSide(color: borderColor, width: 0.5),
                        right: BorderSide(color: borderColor, width: 0.5),
                        bottom: BorderSide(color: borderColor, width: 0.25),
                        left: BorderSide(color: borderColor, width: 0.5),
                      ),
                      isTop: true,
                      prefix: Icon(
                        Icons.person_outline,
                        size: isSmallScreen ? 18 : 20,
                      ),
                    ),
                    CustomAuthTextFieldWidget(
                      controller: _passwordController,
                      validator: FieldsValidators.fieldIsRequired,
                      hintText: 'Contraseña',
                      boxBorder: Border(
                        top: BorderSide(color: borderColor, width: 0.25),
                        right: BorderSide(color: borderColor, width: 0.5),
                        bottom: BorderSide(color: borderColor, width: 0.5),
                        left: BorderSide(color: borderColor, width: 0.5),
                      ),
                      isBottom: true,
                      isPasswordField: true,
                      suffix: SizedBox(width: isSmallScreen ? 35 : 40),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: _getButtonTopPosition(isSmallScreen),
              child: CustomLoginButtonWidget(
                isSmallScreen: isSmallScreen,
                onTap: _loginValidation,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getHorizontalPadding(double width) {
    if (width < 400) return 20;
    if (width < 600) return 30;
    return 40;
  }

  double _getButtonTopPosition(bool isSmallScreen) {
    return isSmallScreen ? 22 : 18;
  }

  void _loginValidation() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _loginAction();
    }
  }

  Future<void> _loginAction() async {
    await ref
        .read(authenticationControllerProvider)
        .loginAction(
          email: _emailController.text.trim(), // <-- usar email
          password: _passwordController.text,
          context: context,
        );
  }
}
