class Job {
  String id;
  String title;
  String description;
  DateTime lastDate;
  num minSalary;
  num maxSalary;
  String howToApply;
  String vendor;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.lastDate,
    required this.minSalary,
    required this.maxSalary,
    required this.howToApply,
    required this.vendor,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      lastDate: DateTime.parse(json['lastDate']),
      minSalary: json['minSalary'],
      maxSalary: json['maxSalary'],
      howToApply: json['howToApply'],
      vendor: json['vendor'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'lastDate': lastDate.toIso8601String(),
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'howToApply': howToApply,
      'vendor': vendor,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
