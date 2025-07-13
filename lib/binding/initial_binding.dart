import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/controller/note_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/repository/expense_repository.dart';
import 'package:expense_tracker/repository/note_repository.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    //for expense
    Get.lazyPut<ExpenseRepository>(() => ExpenseRepository());

    Get.put(ExpenseController(Get.find<ExpenseRepository>()));
    //for note
    Get.lazyPut<NoteRepository>(() => NoteRepository());
    Get.put(NoteController(Get.find<NoteRepository>()));
    //for drawer
    Get.put(ZoomDrawerGetXController());
  }
}
