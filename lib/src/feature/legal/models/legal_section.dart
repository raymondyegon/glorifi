
import 'package:glorifi/src/feature/legal/models/legal_item.dart';

class LegalSection {
  final String title;
  final List<LegalItem> settingItems;

  LegalSection({
    required this.title,
    this.settingItems = const [],
  });
}
