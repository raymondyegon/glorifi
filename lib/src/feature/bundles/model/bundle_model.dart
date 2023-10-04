class BundleModel {
  String name;
  int total;
  int completed;

  List<BundleTask>? tasks;
  List<String>? benefits;

  BundleModel({
    required this.name,
    required this.total,
    required this.completed,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) {
    return BundleModel(
      name: '',
      total: 0,
      completed: 0,
    );
  }
}

class BundleTask {
  String title;
  bool complete;
  String? route;

  BundleTask({
    required this.title,
    required this.complete,
    this.route,
  });
}
