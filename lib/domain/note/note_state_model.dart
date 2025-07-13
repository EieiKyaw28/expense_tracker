import 'package:expense_tracker/domain/note/note.dart';

class NoteStateModel {
  final Note note;
  final bool isCheck;

  NoteStateModel({required this.note, required this.isCheck});

  NoteStateModel copyWith({Note? note, bool? isCheck}) {
    return NoteStateModel(
      note: note ?? this.note,
      isCheck: isCheck ?? this.isCheck,
    );
  }
}
