import 'package:flutter_application_1/controller/db_helper.dart';
import 'package:flutter_application_1/controller/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var task;


  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask ({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
   DBHelper.delete(task);
   getTasks();
  }

  void markTaskCompleted(int id) async{
   await DBHelper.update(id);
   getTasks();
  }
}