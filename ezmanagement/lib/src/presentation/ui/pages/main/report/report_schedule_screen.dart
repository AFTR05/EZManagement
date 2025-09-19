import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';

/// Pantalla para configurar la programación de reportes.
///
/// Permite seleccionar el tipo de reporte, fecha inicial, frecuencia y opción
/// para enviar automáticamente los reportes al correo.
class ReportScheduleScreen extends StatefulWidget {
  /// Constructor del widget.
  const ReportScheduleScreen({super.key});

  @override
  State<ReportScheduleScreen> createState() => _ReportScheduleScreenState();
}

class _ReportScheduleScreenState extends State<ReportScheduleScreen> {
  /// Tipo de reporte seleccionado.
  String _selectedReportType = 'Informe Ejecutivo';

  /// Frecuencia seleccionada para los reportes.
  String _selectedFrequency = 'Mensual';

  /// Fecha inicial seleccionada para iniciar la programación.
  DateTime _selectedDate = DateTime(2025, 7, 1);

  /// Indica si se deben enviar los reportes automáticamente por correo.
  bool _sendAutomatically = true;

  /// Color azul principal usado en la UI.
  static const Color mainBlue = Color(0xFF005DAA);

  /// Abre el selector de fecha con tema personalizado.
  Future<void> _pickDate(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainBlue = Color(0xFF005DAA);

    // Tema personalizado para el selector de fecha según modo claro u oscuro.
    final calendarTheme = ThemeData(
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: mainBlue,
        onPrimary: Colors.white,
        secondary: mainBlue,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: isDark ? EZColorsApp.darkGray : Colors.white,
        onSurface: isDark ? Colors.white : const Color(0xFF242425),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF242425),
          fontFamily: 'OpenSansHebrew',
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF242425),
          fontFamily: 'OpenSansHebrew',
        ),
      ),
      iconTheme: IconThemeData(color: mainBlue),
      highlightColor: mainBlue,
      scaffoldBackgroundColor: isDark ? EZColorsApp.darkGray : Colors.white, dialogTheme: DialogThemeData(backgroundColor: isDark ? EZColorsApp.darkGray : Colors.white),
    );

    // Muestra el selector de fecha con el tema personalizado.
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: calendarTheme,
          child: child!,
        );
      },
    );

    // Actualiza la fecha escogida si cambió.
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// Devuelve la fecha seleccionada formateada en dd/MM/yyyy.
  String _formattedDate() {
    return '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDarkmode ? EZColorsApp.darkBackgroud : Colors.white;
    final cardColor = isDarkmode ? EZColorsApp.darkGray : Colors.white;
    final shadowColor = isDarkmode
        ? EZColorsApp.darkGray.withOpacity(0.16)
        : Colors.black.withOpacity(0.07);
    final textPrimary = isDarkmode ? Colors.white : const Color(0xFF242425);
    final innerBg = isDarkmode ? const Color(0xFF242425) : const Color(0xFFF9F9F9);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: const CustomAppBarWidget(title: "Programación de Reportes"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector del tipo de reporte dentro de una tarjeta personalizada.
            CustomCard(
              title: 'Tipo de reporte',
              cardColor: cardColor,
              shadowColor: shadowColor,
              textPrimary: textPrimary,
              childInnerBgColor: innerBg,
              height: 55,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedReportType,
                  items: ['Informe Ejecutivo', 'Reporte Comercial']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontFamily: 'OpenSansHebrew',
                                  fontWeight: FontWeight.w600,
                                  color: textPrimary),
                            ),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedReportType = v);
                  },
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: mainBlue),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Selector de fecha de inicio con botón para abrir selector.
            CustomCard(
              title: 'Fecha de inicio',
              cardColor: cardColor,
              shadowColor: shadowColor,
              textPrimary: textPrimary,
              childInnerBgColor: innerBg,
              height: 55,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _formattedDate(),
                      style: TextStyle(
                          fontFamily: "OpenSansHebrew",
                          fontSize: 16,
                          color: textPrimary),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today_rounded, color: mainBlue),
                    onPressed: () => _pickDate(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Selector de frecuencia de envío.
            CustomCard(
              title: 'Frecuencia',
              cardColor: cardColor,
              shadowColor: shadowColor,
              textPrimary: textPrimary,
              childInnerBgColor: innerBg,
              height: 55,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFrequency,
                  items: ['Mensual', 'Semanal']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontFamily: 'OpenSansHebrew',
                                  fontWeight: FontWeight.w600,
                                  color: textPrimary),
                            ),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedFrequency = v);
                  },
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: mainBlue),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 26),

            // Switch para activar o desactivar envío automático por correo.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Enviar automáticamente\nal correo",
                    style: TextStyle(
                      fontFamily: 'OpenSansHebrew',
                      fontSize: 16,
                      color: textPrimary,
                    ),
                  ),
                ),
                Switch(
                  value: _sendAutomatically,
                  activeColor: Colors.white,
                  activeTrackColor: EZColorsApp.ezAppColor,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: EZColorsApp.lightGray,
                  trackOutlineColor: MaterialStateProperty.all(
                    _sendAutomatically ? EZColorsApp.ezAppColor : EZColorsApp.lightGray,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _sendAutomatically = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 26),

            // Título para sección de reportes programados.
            Text('Reportes programados',
                style: TextStyle(
                  fontFamily: 'OpenSansHebrew',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: textPrimary,
                )),
            const SizedBox(height: 8),

            // Tarjeta resumen que muestra la configuración actual del reporte.
            CustomCard(
              cardColor: cardColor,
              shadowColor: shadowColor,
              textPrimary: textPrimary,
              childInnerBgColor: Colors.transparent,
              height: 55,
              child: _SummaryContent(
                title: "Informe Ejecutivo",
                frequency: _selectedFrequency,
                dateLabel: _formattedDate(),
                iconAsset: "assets/images/icons/email_document_icon.svg",
                mainBlue: mainBlue,
              ),
            ),

            const SizedBox(height: 16),

            // Botón para modificar la programación de reportes.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                ),
                onPressed: () {
                  // Acción pendiente para modificar programación.
                },
                child: Text('Modificar Programación',
                    style: TextStyle(
                      fontFamily: "OpenSansHebrew",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta personalizada con título, contenido y estilos de diseño.
///
/// Widget reutilizable para secciones en la pantalla de programación.
class CustomCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final Color cardColor;
  final Color shadowColor;
  final Color textPrimary;
  final Color childInnerBgColor;
  final double? height;

  /// Constructor con parámetros para personalizar la tarjeta.
  const CustomCard({
    this.title,
    required this.child,
    required this.cardColor,
    required this.shadowColor,
    required this.textPrimary,
    required this.childInnerBgColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 15,
            offset: const Offset(1, 1),
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Text(title!,
                  style: TextStyle(
                      fontFamily: 'OpenSansHebrew',
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                      fontSize: 15)),
            ),
          SizedBox(
            height: height,
            child: Container(
              decoration: BoxDecoration(
                color: childInnerBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(child: child),
            ),
          ),
        ],
      ),
    );
  }
}

/// Contenido resumen mostrado dentro de la tarjeta personalizada.
///
/// Muestra el título, fecha, frecuencia e ícono representativo del reporte.
class _SummaryContent extends StatelessWidget {
  final String title;
  final String frequency;
  final String dateLabel;
  final String iconAsset;
  final Color mainBlue;

  /// Constructor que requiere toda la información a mostrar.
  const _SummaryContent({
    required this.title,
    required this.frequency,
    required this.dateLabel,
    required this.iconAsset,
    required this.mainBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontFamily: 'OpenSansHebrew',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                const SizedBox(height: 4),
                Text(dateLabel,
                    style: const TextStyle(
                      fontFamily: 'OpenSansHebrew',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    )),
              ]),
        ),
        Column(
          children: [
            Text(frequency,
                style: TextStyle(
                    fontFamily: 'OpenSansHebrew',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: mainBlue)),
            const SizedBox(height: 7),
            SvgPicture.asset(iconAsset,
                width: 28, height: 28, colorFilter: ColorFilter.mode(mainBlue, BlendMode.srcIn)),
          ],
        ),
        const SizedBox(width: 10),
        Icon(Icons.chevron_right, color: mainBlue.withOpacity(0.7), size: 27),
      ],
    );
  }
}