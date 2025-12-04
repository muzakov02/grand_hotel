class Facilities {
  final String id;
  final String name;
  final String iconPath;
  final List<String> facilities;
  bool isExpanded;

  Facilities({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.facilities,
    this.isExpanded = false,
  });
}
