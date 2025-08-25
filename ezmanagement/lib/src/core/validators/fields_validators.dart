import 'package:easy_localization/easy_localization.dart';
import 'package:ezmanagement/translations/locale_keys.g.dart';
class FieldsValidators {
  static String? fieldIsRequired(String? text) {
    if (text == null || text.isEmpty) {
      return LocaleKeys.fieldIsRequired.tr();
    }
    return null;
  }
  
}