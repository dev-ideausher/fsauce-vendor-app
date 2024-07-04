///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class PushNotification {
/*
{
  "title": "Don't miss the offer, 15 days free trial now valida till date 15 feb",
  "sheduledDate": "2024-07-17"
}
*/

  String? title;
  String? sheduledDate;

  PushNotification({
    this.title,
    this.sheduledDate,
  });
  PushNotification.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    sheduledDate = json['sheduledDate']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['sheduledDate'] = sheduledDate;
    return data;
  }
}
