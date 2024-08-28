

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils/databse_service.dart';
import 'package:todo_app/utils/snackbar.dart';

class AddTodosController extends GetxController{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController priorityC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final TextEditingController timeC = TextEditingController();
  final TextEditingController searchC = TextEditingController();



  List<TodoModel>todoList = [];
   List<TodoModel>searchList= [];
  @override
  void onInit() {
    super.onInit();

    dateC.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    timeC.text = DateFormat('HH:mm').format(DateTime.now());

    fetchTodos();
  }




  @override
  void onClose() {
    // TODO: implement onClose

    titleC.dispose();
    descriptionC.dispose();
    priorityC.dispose();
    dateC.dispose();
    timeC.dispose();
    searchC.dispose();

    super.onClose();

  }





  void pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      dateC.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
  }



  void pickTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
      timeC.text = DateFormat('HH:mm').format(dateTime);
    }
  }






  void startReminderTimer(TodoModel todo) {
    final now = DateTime.now();
    final reminderTime = DateTime(
        now.year, now.month, now.day, int.parse(todo.time!.split(':')[0]),
        int.parse(todo.time!.split(':')[1]));

    if (reminderTime.isAfter(now)) {
      final duration = reminderTime.difference(now);
      Timer(duration, () async {


        _sendNotification(todo);



      });
    }
  }
  Future<void> saveTodo() async {

    if(titleC.text.isEmpty){

    CustomSnackbar.show(
      title: 'Title',
      message: 'Please fill title',

    );

      return;
    }
    if(descriptionC.text.isEmpty){

      CustomSnackbar.show(
        title: 'Description',
        message: 'Please fill description',

      );
      return;
    }
    if(priorityC.text.isEmpty){
      CustomSnackbar.show(
        title: 'Priority',
        message: 'Please fill priority',

      );

      return;
    }
    final title = titleC.text.trim();
    final description = descriptionC.text.trim();
    final priority = int.tryParse(priorityC.text.trim()) ?? 1;
    final dueDate = DateFormat('dd/MM/yyyy').parse(dateC.text.trim());
    final time = timeC.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      TodoModel todoModel = TodoModel(
        id: null,
        title: title,
        description: description,
        dueDate: dueDate,
        time: time,
        priority: priority,
      );

      await DatabaseService().insertTodo(todoModel);
      await fetchTodos();

      startReminderTimer(todoModel);

      // update();
      print("complete add data insert");
// Get.toNamed('/homeScreen');
      Get.back();
    } else {

      print("no add data insert");
      // Get.snackbar('Error', 'Please fill all fields');
    }
  }



  Future<void> fetchTodos() async {
    todoList = await DatabaseService().getTodo();

    // searchList = todoList;
    update(); // Update the UI
  }


  void buildSearch(String query) {
    if (query.isEmpty) {
      // If query is empty, reset to the original list
      searchList = List.from(todoList);
    } else {
      final lowerCaseQuery = query.toLowerCase();
      searchList = todoList
          .where((todo) => todo.title?.toLowerCase().contains(lowerCaseQuery) ?? false)
          .toList();
    }
    update(); // Update the UI
  }



  Future<void> deleteTodoById(int id) async {
    await DatabaseService().deleteTodoById(id);
    await fetchTodos();
    update();
    // Refresh the list after deletion
  }


  Future<void> updateTodo(int id) async {
    final updatedTodo = TodoModel(
      id: id,
      title: titleC.text,
      description: descriptionC.text,
      priority: int.tryParse(priorityC.text),
      dueDate: dateC.text.isNotEmpty ? DateFormat('dd/MM/yyyy').parse(dateC.text) : null,
      time: timeC.text,
    );

    await DatabaseService().updateTask(updatedTodo);
    await fetchTodos();


Get.toNamed('/homeScreen');

  }




  void _sendNotification(TodoModel todo) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Channel ID
      'your_channel_name', // Channel Name
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      todo.id ?? 0, // Notification ID
      'Reminder: ${todo.title}', // Notification Title
      todo.description, // Notification Body
      platformChannelSpecifics,
      payload: 'Todo ID: ${todo.id}', // Payload
    );
  }
}
