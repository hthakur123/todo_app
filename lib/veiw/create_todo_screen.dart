




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/add_todos_controller.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils/custom_textforfiild.dart';
import 'package:todo_app/utils/text_utile.dart';

class CreateTodoScreen extends StatelessWidget {
  const CreateTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final TodoModel? todo = Get.arguments;

    return  GetBuilder(
      init: AddTodosController(),
      builder:  (controller) {
        if (todo != null) {
          controller.titleC.text = todo.title ?? '';
          controller.descriptionC.text = todo.description ?? '';
          controller.priorityC.text = todo.priority?.toString() ?? '';
          controller.dateC.text = todo.dueDate != null
              ? DateFormat('dd/MM/yyyy').format(todo.dueDate!)
              : '';
          controller.timeC.text = todo.time ?? '';
        }

      return  Scaffold(

        backgroundColor: Colors.grey.shade100,


        appBar: AppBar(

          leading: IconButton(onPressed:  () {

            Get.back();

          }, icon:  const Icon(Icons.arrow_back_ios,color: Colors.black,)),
          elevation: 0,
          centerTitle: true,

          backgroundColor: Colors.grey.shade100,

          title: Apputile.widgetText(
              textColor: Colors.black,


              text: todo!=null?"Edit Todo":"Create Todo"
          ),



        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                // const SizedBox(height: 4,),
          
          
                Apputile.widgetText(
                    text: "Title",
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
          
                const SizedBox(height: 10,),
          
                CustomTextFormField(
                  controller:  controller.titleC,
                  textStyle: const TextStyle(
                  ),
                  hintText: "Enter Title",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  fillColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
          
          
          
                ),
                const SizedBox(height: 30,),
                Apputile.widgetText(
                    text: "Description",
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
          
                const SizedBox(height: 10,),
          
                CustomTextFormField(
                  controller:  controller.descriptionC,
                  textStyle: const TextStyle(
                  ),
                  hintText: "Enter Description",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  fillColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
          
          
          
                ),
          
                const SizedBox(height: 30,),
                Apputile.widgetText(
                    text: "Priority",
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
          
                const SizedBox(height: 10,),
          
                CustomTextFormField(
                  keyboardType: TextInputType.number ,
                  controller:  controller.priorityC,
                  textStyle: const TextStyle(
                  ),
                  hintText: "Enter Priority",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  fillColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
          
          
          
                ),
                const SizedBox(height: 30,),
          
          
                Apputile.widgetText(
                    text: "Date",
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
          
                const SizedBox(height: 10,),
          
                CustomTextFormField(
                  controller:  controller.dateC,
                  textStyle: const TextStyle(
                  ),
                  hintText: "Select Date",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  fillColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),

                  suffixIcon: IconButton(onPressed: () {

                    controller.pickDate(context);

                  }, icon: const Icon(Icons.calendar_month_rounded,size: 30,)),
          
          
          
                ),
          
                const SizedBox(height: 30,),
          
                Apputile.widgetText(
                    text: "Time",
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
          
                const SizedBox(height: 10,),
          
                CustomTextFormField(
                  controller:  controller.timeC,
                  textStyle: const TextStyle(
                  ),
                  hintText: "Select Time",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  fillColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),

                  suffixIcon: IconButton(onPressed: () {
                    
                    controller.pickTime(context);

                  }, icon: const Icon(Icons.timer_outlined,size: 30,)),


                ),
                
                
                const SizedBox(height: 50,),
          
          
                InkWell(
                  onTap: () {
                    if (todo == null) {
                      controller.saveTodo();
                    } else {
                      controller.updateTodo(todo.id!);
                    }                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:   Text(todo!=null?"Update":"Continue",style: const TextStyle(
                      color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                    ),),

                  ),
                )
                
              ],
            ),
          ),
        ),
      );
    },);



  }
}
