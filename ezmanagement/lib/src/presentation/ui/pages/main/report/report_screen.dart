import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // <- tr()
import 'package:ezmanagement/translations/locale_keys.g.dart'; // <- LocaleKeys
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final double scale = size.width < 360
        ? 0.85
        : (size.width < 600 ? 1.0 : 1.2);
    final items = <Map<String, Object>>[
      {
        'titleKey': LocaleKeys.reportAdvancedTitle,
        'subtitleKey': LocaleKeys.reportAdvancedSubtitle,
        'icon': Icons.bar_chart_rounded,
        'color': Colors.purple,
        'onTap': () => debugPrint('Navegando a Reportes Avanzados'),
      },
      {
        'titleKey': LocaleKeys.reportExecutiveTitle,
        'subtitleKey': LocaleKeys.reportExecutiveSubtitle,
        'icon': Icons.business_center_rounded,
        'color': Colors.green,
        'onTap': () => debugPrint('Navegando a Informe Ejecutivo'),
      },
      {
        'titleKey': LocaleKeys.reportScheduleTitle,
        'subtitleKey': LocaleKeys.reportScheduleSubtitle,
        'icon': Icons.schedule_rounded,
        'color': Colors.orange,
        'onTap': () => debugPrint('Navegando a Programación De Reportes'),
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16 * scale,
                  20 * scale,
                  16 * scale,
                  8 * scale,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 16 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.reportHeaderTitle.tr(), // <- usando tr()
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20 * scale,
                              color:
                                  (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : EZColorsApp.darkColorText),
                              fontFamily: 'OpenSansHebrew',
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            LocaleKeys.reportHeaderSubtitle.tr(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 14 * scale,
                              color:
                                  (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : EZColorsApp.darkColorText)
                                      .withValues(alpha: .7),
                              fontFamily: 'OpenSansHebrew',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Lista
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16 * scale,
                8 * scale,
                16 * scale,
                24 * scale,
              ),
              sliver: SliverList.separated(
                itemCount: items.length,
                separatorBuilder: (_, _) => SizedBox(height: 12 * scale),
                itemBuilder: (context, i) => _reportCard(
                  context: context,
                  title: (items[i]['titleKey'] as String).tr(), // <- tr() aquí
                  subtitle: (items[i]['subtitleKey'] as String)
                      .tr(), // <- tr() aquí
                  icon: items[i]['icon'] as IconData,
                  onTap: items[i]['onTap'] as VoidCallback,
                  scale: scale,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required double scale,
  }) {
    final theme = Theme.of(context);
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? EZColorsApp.darkBackgroud
          : Colors.white,
      elevation: 1.5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12 * scale,
            vertical: 6 * scale,
          ),
          child: ListTile(
            leading: DecoratedBox(
              decoration: BoxDecoration(
                color: EZColorsApp.ezAppColor.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Padding(
                padding: EdgeInsets.all(10 * scale),
                child: Icon(
                  icon,
                  color: EZColorsApp.ezAppColor,
                  size: 22 * scale,
                ),
              ),
            ),
            title: Text(
              title, // <- ya viene traducido
              style: theme.textTheme.titleMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : EZColorsApp.darkColorText,
                fontWeight: FontWeight.w600,
                fontSize: 16 * scale,
                fontFamily: 'OpenSansHebrew',
              ),
            ),
            subtitle: Text(
              subtitle, // <- ya viene traducido
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12 * scale,
                color:
                    (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : EZColorsApp.darkColorText)
                        .withValues(alpha: .7),
                fontFamily: 'OpenSansHebrew',
              ),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              size: 22 * scale,
              color: EZColorsApp.ezAppColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8 * scale,
              vertical: 6 * scale,
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
      ),
    );
  }
}
