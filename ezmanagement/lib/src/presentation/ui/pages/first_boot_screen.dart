import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstBootScreen extends ConsumerStatefulWidget {
  const FirstBootScreen({super.key});

  @override
  ConsumerState<FirstBootScreen> createState() => _FirstBootScreenState();
}

class _FirstBootScreenState extends ConsumerState<FirstBootScreen>
    with TickerProviderStateMixin {
  // Timings
  static const _logoDuration = Duration(milliseconds: 1000);
  static const _progressDuration = Duration(milliseconds: 1800);
  static const _staggerDelay = Duration(milliseconds: 350);
  static const _minSplashVisible = Duration(milliseconds: 1400);
  static const _decideTimeout = Duration(seconds: 8);

  // Mensajes de estado
  static const List<String> _statusSteps = <String>[
    'Inicializando módulos…',
    'Cargando configuración…',
    'Verificando sesión…',
    'Preparando tu sesión…',
  ];

  late final AnimationController _logoCtrl;
  late final AnimationController _progressCtrl;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _progressValue;
  late final Animation<double> _textFade;

  String _statusMessage = _statusSteps.first;
  bool _hasError = false;
  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startFlow());
  }

  void _initAnimations() {
    _logoCtrl = AnimationController(vsync: this, duration: _logoDuration);
    _progressCtrl = AnimationController(vsync: this, duration: _progressDuration);

    _logoScale = CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOutBack)
        .drive(Tween(begin: 0.7, end: 1.0));
    _logoFade = CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOut)
        .drive(Tween(begin: 0.0, end: 1.0));

    _progressValue = CurvedAnimation(parent: _progressCtrl, curve: Curves.easeInOut)
        .drive(Tween(begin: 0.0, end: 1.0));
    _textFade = CurvedAnimation(
      parent: _progressCtrl,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ).drive(Tween(begin: 0.0, end: 1.0));
  }

  Future<void> _startFlow() async {
    setState(() {
      _hasError = false;
      _isRetrying = false;
      _statusMessage = _statusSteps.first;
    });

    final started = DateTime.now();
    _runStatusSequence();

    _logoCtrl.forward();
    await Future<void>.delayed(_staggerDelay);
    _progressCtrl.forward();

    // Decide ruta con timeout y fallback a login + mensajes
    late bool isLogged;
    try {
      isLogged = await ref
          .read(authenticationControllerProvider)
          .isLoggedUser()
          .timeout(_decideTimeout);
    } catch (_) {
      isLogged = false;
      _onAuthError();
    }

    // Garantiza tiempo mínimo visible del splash
    final elapsed = DateTime.now().difference(started);
    if (elapsed < _minSplashVisible) {
      await Future<void>.delayed(_minSplashVisible - elapsed);
    }

    if (!mounted) return;
    if (_hasError) return; // si hubo error, esperamos acción del usuario

    _go(isLogged ? RoutesApp.home : RoutesApp.login);
  }

  /// Avanza mensajes de estado con pequeñas pausas
  Future<void> _runStatusSequence() async {
    // Recorre y muestra cada mensaje con un intervalo corto
    for (int i = 0; i < _statusSteps.length; i++) {
      if (!mounted || _hasError) return;
      setState(() => _statusMessage = _statusSteps[i]);
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
  }

  void _onAuthError() {
    if (!mounted) return;
    setState(() {
      _hasError = true;
      _statusMessage = 'Sin conexión o servicio no disponible.';
    });
    _showSnack('No pudimos verificar tu sesión. Revisa tu conexión e inténtalo de nuevo.');
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
  }

  Future<void> _retry() async {
    if (_isRetrying) return;
    setState(() {
      _isRetrying = true;
      _hasError = false;
      _statusMessage = 'Reintentando…';
    });
    _showSnack('Reintentando verificación…');
    await _startFlow();
  }

  void _go(String route) {
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (r) => false);
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brand = EZColorsApp.ezAppColor;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: isDark ? EZColorsApp.darkBackgroud : Colors.white,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, c) {
              final compact = c.maxHeight < 640;
              final logoSide =
                  (c.biggest.shortestSide * 0.35).clamp(120.0, 280.0);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LOGO (fade + scale)
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Semantics(
                        label: 'EZ Solutions logo',
                        image: true,
                        child: SizedBox(
                          width: logoSide,
                          height: logoSide,
                          child: SvgPicture.asset(
                            'assets/images/ez_solutions_logo.svg',
                            colorFilter: ColorFilter.mode(
                              isDark ? Colors.white : brand,
                              BlendMode.srcIn,
                            ),
                            semanticsLabel: 'EZ Solutions',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: compact ? 12 : 18),

                  // PROGRESS + MENSAJE
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: compact ? 40 : 60),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AnimatedBuilder(
                            animation: _progressValue,
                            builder: (context, _) {
                              return LinearProgressIndicator(
                                value: _progressValue.value,
                                minHeight: 4,
                                backgroundColor: isDark
                                    ? EZColorsApp.grayColor.withOpacity(0.28)
                                    : brand.withOpacity(0.12),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(brand),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeTransition(
                          opacity: _textFade,
                          child: Text(
                            _statusMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? EZColorsApp.lightGray
                                  : EZColorsApp.grayColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),

                        // Botón de reintento solo si hubo error
                        if (_hasError) ...[
                          const SizedBox(height: 12),
                          TextButton.icon(
                            onPressed: _isRetrying ? null : _retry,
                            icon: const Icon(Icons.refresh),
                            label: Text(
                              _isRetrying ? 'Reintentando…' : 'Reintentar',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
