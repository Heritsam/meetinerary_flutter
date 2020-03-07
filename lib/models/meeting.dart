import 'dart:convert';

Meeting meetingFromJson(String str) => Meeting.fromJson(json.decode(str));

String meetingToJson(Meeting data) => json.encode(data.toJson());

class Meeting {
  int id;
  String title;
  String description;
  DateTime datetime;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  Meeting({
    this.id,
    this.title,
    this.description,
    this.datetime,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    datetime: DateTime.parse(json["datetime"]),
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "datetime": datetime.toIso8601String(),
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}