import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // función de fuente responsiva como en tu Home
  double _rf(BuildContext context, double base,
      {double min = 12, double max = 34}) {
    final size = MediaQuery.of(context).size;
    final shortest = size.shortestSide;
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? EZColorsApp.darkBackgroud
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView( // 👈 Scroll global
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCalendar(context, screenHeight),
                      const SizedBox(height: 12),
                      _buildEventList(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: EZColorsApp.ezAppColor,
        onPressed: () {
          debugPrint("Agregar nuevo evento");
        },
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: screenHeight * 0.04,
        left: 20,
        right: 20,
        bottom: screenHeight * 0.04,
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
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Octubre",
            style: TextStyle(
              fontSize: _rf(context, 24, min: 18, max: 30),
              fontFamily: 'OpenSansHebrew',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "2025",
            style: TextStyle(
              fontSize: _rf(context, 16, min: 12, max: 20),
              fontFamily: 'OpenSansHebrew',
              color: Colors.white.withValues(alpha: .7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.50, 
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: EZColorsApp.grayColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: EZColorsApp.ezAppColor.withOpacity(.3),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: EZColorsApp.ezAppColor,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(BuildContext context) {
    return Column(
      children: [
        _buildEventCard(
          context,
          time: "10:00 - 13:00",
          title: "Venta mayorista al Hotel Los Tulipanes",
          subtitle: "Entrega de lote 25 – Bodega",
          color: Colors.pinkAccent,
        ),
        const SizedBox(height: 12),
        _buildEventCard(
          context,
          time: "14:00 - 15:00",
          title: "Cierre de ventas con Cliente Herrera",
          subtitle: "Confirmación de pedido y programación de entrega",
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context,
      {required String time,
      required String title,
      required String subtitle,
      required Color color}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? EZColorsApp.darkBackgroud
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: _rf(context, 14, min: 12, max: 18),
                    fontFamily: 'OpenSansHebrew',
                    color: EZColorsApp.grayColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _rf(context, 16, min: 14, max: 20),
                    fontFamily: 'OpenSansHebrew',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : EZColorsApp.darkColorText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: _rf(context, 13, min: 12, max: 16),
                    fontFamily: 'OpenSansHebrew',
                    color: EZColorsApp.grayColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
