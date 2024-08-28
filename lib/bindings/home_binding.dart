


import 'package:get/get.dart';
import 'package:todo_app/controller/add_todos_controller.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => AddTodosController(),);
  }

}