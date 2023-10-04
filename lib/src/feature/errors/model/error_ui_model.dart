class ErrorUiModel {
  final String? svgIconPath;
  final String title;
  final String subtitle;
  final String content;
  final String actionTitle;
  Function()? action;

  ErrorUiModel({
    this.svgIconPath,
    required this.title,
    this.subtitle = "",
    this.content = "",
    required this.actionTitle,
    this.action,
  });
}
