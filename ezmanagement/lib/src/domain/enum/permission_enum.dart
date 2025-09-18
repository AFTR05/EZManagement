enum PermissionEnum {
  managePassword('manage password'),
  manageUsers('manage users'),
  manageRoles('manage roles'),
  deleteAccount('delete account'),
  viewAdvancedReports('view advanced reports'),
  generateExecutiveReport('generate executive report'),
  scheduleReports('schedule reports'),
  viewCalendar('view calendar'),
  manageProducts('manage products'),
  manageMaterials('manage materials'),
  registerSales('register sales');

  const PermissionEnum(this.label);
  final String label;

  static PermissionEnum? fromString(String s, {bool caseInsensitive = true}) {
    final needle = caseInsensitive ? s.toLowerCase().trim() : s.trim();
    for (final p in PermissionEnum.values) {
      final hay = caseInsensitive ? p.label.toLowerCase() : p.label;
      if (hay == needle) return p;
    }
    return null;
  }

  static List<PermissionEnum> fromStrings(Iterable<String> labels, {bool caseInsensitive = true}) =>
      labels.map((s) => fromString(s, caseInsensitive: caseInsensitive))
            .whereType<PermissionEnum>()
            .toList(growable: false);

  static List<String> toStrings(Iterable<PermissionEnum> perms) =>
      perms.map((p) => p.label).toList(growable: false);

  static List<String> allStrings() =>
      PermissionEnum.values.map((p) => p.label).toList(growable: false);
}
