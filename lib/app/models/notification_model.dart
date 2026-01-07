class NotificationModel {
  final String? id;
  final String? title;
  final bool? isSheduled;
  final DateTime? sheduledDate;
  final bool? isActive;
  final bool? isPublished;
  final String? vendor;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationModel({
    this.id,
    this.title,
    this.isSheduled,
    this.sheduledDate,
    this.isActive,
    this.isPublished,
    this.vendor,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["_id"],
        title: json["title"],
        isSheduled: json["isSheduled"],
        sheduledDate: json["sheduledDate"] == null
            ? null
            : DateTime.parse(json["sheduledDate"]),
        isActive: json["isActive"],
        isPublished: json["isPublished"],
        vendor: json["vendor"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
  if (diff.inHours < 24) return "${diff.inHours}h ago";
  return "${diff.inDays}d ago";
}
