import 'package:todo_app/Model/task_model.dart';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_app/utils/api_const.dart';

class APIReq {
  String baseUrl = ApiConst().baseUrl;
  Future<Map> createTask({required TaskModel createTaskData}) async {
    final res = await post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'taskTitle': createTaskData.taskTitle,
        'taskDesc': createTaskData.taskDesc,
      }),
    );

    var jsonData = jsonDecode(res.body);
    //print(res.statusCode);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return {'status': 'success', 'data': 'Task Created'};
    } else {
      return {'status': 'failed', 'data': jsonData['message']};
    }
  }

  Future<Map> getTask() async {
    final res = await get(
      Uri.parse(baseUrl),
    );
    var jsonData = jsonDecode(res.body);

    if (res.statusCode == 200) {
      List taskData = [];
      for (var ele in jsonData) {
        taskData.add(TaskModel.fromJson(ele));
      }
      return {'status': 'success', 'data': taskData};
    } else {
      return {'status': 'failed', 'data': jsonData['message']};
    }
  }

  Future<Map> updateTask(
      {required String taskId, required TaskModel updateTaskData}) async {
    final res = await put(
      Uri.parse('$baseUrl/$taskId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'taskTitle': updateTaskData.taskTitle,
        'taskDesc': updateTaskData.taskDesc,
      }),
    );

    var jsonData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return {'status': 'success', 'data': jsonData['message']};
    } else {
      return {'status': 'failed', 'data': jsonData['message']};
    }
  }

  Future<Map> deleteTask({
    required String taskId,
  }) async {
    final res = await delete(
      Uri.parse('$baseUrl/$taskId'),
    );

    var jsonData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return {'status': 'success', 'data': jsonData['message']};
    } else {
      return {'status': 'failed', 'data': jsonData['message']};
    }
  }
}
