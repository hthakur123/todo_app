import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/todo_model.dart';
import '../controller/add_todos_controller.dart';
import '../utils/text_utile.dart';

class DataShowScreen extends StatelessWidget {
  const DataShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoModel todo = Get.arguments;
    final AddTodosController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.searchC.clear();

            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        title: Apputile.widgetText(
          textColor: Colors.black,
          text: "Todos Data",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Get.toNamed('/createTodoScreen', arguments: todo);



              },
              child: Image.asset(
                "assets/images/edit.png",
                height: 20,
                width: 25,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  buildDetailRow("Title", todo.title),
                  const SizedBox(height: 15),
                  buildDetailRow("Description", todo.description),
                  const SizedBox(height: 15),
                  buildDetailRow("Priority", todo.priority.toString()),
                  const SizedBox(height: 15),
                  buildDetailRow(
                      "Date",
                      todo.dueDate != null
                          ? DateFormat('dd/MM/yyyy').format(todo.dueDate!)
                          : "No date"
                  ),
                  const SizedBox(height: 15),
                  buildDetailRow("Time", todo.time.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, dynamic value) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Apputile.widgetText(
            text: "$label:",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Flexible(
          child: Apputile.widgetText(
            text: value,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
