import 'package:expense_tracker/domain/note/note.dart';
import 'package:expense_tracker/domain/note/note_state_model.dart';
import 'package:expense_tracker/repository/note_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NoteController extends GetxController {
  final NoteRepository noteRepo;

  NoteController(this.noteRepo);
  List<NoteStateModel> noteList = <NoteStateModel>[];

  @override
  void onInit() {
    super.onInit();
    fetchNote();
  }

  Future<void> fetchNote() async {
    noteRepo.getNoteList().listen((note) {
      noteList =
          note.map((n) => NoteStateModel(note: n, isCheck: false)).toList();
      update();
    });
  }

  void onCheck(int index) {
    noteList[index] = noteList[index].copyWith(
      isCheck: !noteList[index].isCheck,
    );

    update();
  }

  void checkAll(bool check) {
    noteList = noteList.map((item) => item.copyWith(isCheck: check)).toList();

    update();
  }

  Future<Note?> getNoteById(int id) async {
    final note = await noteRepo.getNoteById(id);

    return note;
  }

  Future<void> addNote(String note) async {
    await noteRepo.addNote(note);
    fetchNote();
  }

  Future<void> deleteNote() async {
    for (var x in noteList.where((e) => e.isCheck == true)) {
      await noteRepo.deleteNote(x.note.id);
    }

    fetchNote();
  }
}
