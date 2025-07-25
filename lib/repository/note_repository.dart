import 'dart:async';
import 'dart:developer';

import 'package:expense_tracker/domain/note/note.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class NoteRepository {
  Stream<List<Note>> getNoteList() {
    return isar.notes
        .where()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  Future<Note?> getNoteById(int id) async {
    final note = await isar.notes
        .where()
        .idEqualTo(id)
        .sortByCreatedAtDesc()
        .findFirst();
    return note;
  }

  Future<void> addNote(String noteString, int? id) async {
    try {
      Note? note;
      await isar.writeTxn(() async {
        if (id != null) {
          note = await isar.notes.get(id);
        }

        if (note != null) {
          note?.note = noteString;
        } else {
          note = Note()
            ..note = noteString
            ..createdAt = DateTime.now().toUtc();
        }

        await isar.notes.put(note!);
      });

      Navigator.pop(navigatorKey.currentContext!);
    } catch (e, st) {
      log("Note Error : $e $st");
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.notes.delete(id);
      });
    } catch (e, st) {
      log("Note Error : $e $st");
    }
  }
}
