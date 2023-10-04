import 'package:glorifi/src/feature/legal/models/settings_name.dart';

class LegalItem {
  final String title;
  final SettingsName settingsName;
  final bool isLastElement;

  LegalItem({
    required this.title,
    required this.settingsName,
    required this.isLastElement,
  });
}
