// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String? id;
  String taskTitle;
  String taskDesc;

  TaskModel({
    this.id,
    required this.taskTitle,
    required this.taskDesc,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["_id"],
        taskTitle: json["taskTitle"],
        taskDesc: json["taskDesc"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "taskTitle": taskTitle,
        "taskDesc": taskDesc,
      };
}
