class NotificationModel {
  final String id;
  final String title;
  final String imageUrl;
  final String time;

  NotificationModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.time,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? time,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      time: time ?? this.time,
    );
  }
}
