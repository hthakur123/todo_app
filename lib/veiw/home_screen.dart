


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/add_todos_controller.dart';
import 'package:todo_app/utils/custom_textforfiild.dart';
import 'package:todo_app/utils/text_utile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
  GetBuilder(
    init: AddTodosController(),
    builder: (controller) {
    return     Scaffold (
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(onPressed:  () {

        }, icon: const Icon(Icons.menu,color: Colors.black,)),
        elevation: 0,
        centerTitle: true,

        backgroundColor: Colors.grey.shade100,

        title: Apputile.widgetText(
            textColor: Colors.black,

            text: "Todo App"
        ),

        actions: [

          IconButton(onPressed:  () {

            Get.toNamed('/createTodoScreen');

            controller.titleC.clear();
            controller.descriptionC.clear();
            controller.priorityC.clear();
            controller.searchC.clear();
            // controller.timeC.clear();
            // controller.dateC.clear();

          }, icon: const Icon(Icons.add,color: Colors.black,size: 32,))
        ],



      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20,),
            CustomTextFormField(
controller:  controller.searchC,
              textStyle: const TextStyle(
              ),
              hintText: "Search For todo’s",
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
              fillColor: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              suffixIcon: const Icon(Icons.search),
              onChanged: (value) {
                controller.buildSearch(value);
              },


            ),

            const SizedBox(height: 40,),


            Apputile.widgetText(

                text: "All ToDos",
                fontSize: 25,
                fontWeight: FontWeight.w600
            ),




            const SizedBox(height: 10,),






            controller.todoList.isEmpty?Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: InkWell(
                   onTap: () {
                     controller.titleC.clear();
                     controller.descriptionC.clear();
                     controller.priorityC.clear();
                     controller.searchC.clear();
                     Get.toNamed('/createTodoScreen');

                   },
                  child: Card(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Image.asset(
                          "assets/images/to-do-list.png",
                          height: 30,
                          width: 30,
                        ),

                        SizedBox(width: 15,),
                        Apputile.widgetText(

                          text: "Create todos",
                          fontWeight: FontWeight.bold

                        ),
                        SizedBox(width: 15,),

                        IconButton(onPressed:  () {

                        }, icon: Icon(Icons.arrow_forward_ios_outlined))
                      ],
                    )
                  ),
                ),
              ),
            ):
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:   controller.searchList.isNotEmpty?controller.searchList.length:controller.todoList.length,
                itemBuilder:  (context, index) {

                  final todo  = controller.searchList.isNotEmpty?controller.searchList[index]:controller.todoList[index];
                return  InkWell(
                   onTap: () {

                     Get.toNamed('/dataShowScreen',arguments: todo);
                   },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),

                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),

                    child: ListTile(

                    leading:  Image.asset(
                      "assets/images/to-do-list.png",
                      // height: 30,
                      width: 30,
                    ),
                      title: Apputile.widgetText(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        text: "${todo.title}",
                      ),
                      subtitle: Apputile.widgetText(
                        text: "${todo.description}"
                      ),

                      trailing: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(5),

                            color: Colors.red
                        ),

                        child: InkWell(

                          onTap: () {
                            controller.deleteTodoById(todo.id!);

                          },
                            child: const Icon(Icons.delete,color: Colors.white,size: 30,)),
                      ),
                    ),
                  ),
                );
              },),
            ),







          ],
        ),
      ),
    );
  },);
  }
}
