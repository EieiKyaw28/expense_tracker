import 'dart:convert';
import 'dart:developer';

import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/controller/note_controller.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/presentation/note/note_create_page.dart';
import 'package:expense_tracker/repository/note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
  });

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool onLongPress = false;
  bool checkAll = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final noteController = Get.find<NoteController>();

      noteController.fetchNote();
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<ZoomDrawerGetXController>();
    final noteRepo = Get.find<NoteRepository>();

    return GetBuilder<NoteController>(
        init: NoteController(noteRepo),
        builder: (controller) {
          final notes = controller.noteList;
          return CommonScaffold(
            appBar: onLongPress
                ? CommonAppBar(
                    hasDrawer: false,
                    noLeadingIcon: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              onLongPress = false;
                              setState(() {});
                            },
                            child: const Icon(Icons.close)),
                        80.hGap,
                        controller.noteList.every((e) => e.isCheck == false)
                            ? const Text(
                                "My Notes",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "${controller.noteList.where((e) => e.isCheck).length} ${controller.noteList.where((e) => e.isCheck).length == 1 ? "Note" : "Notes"} Selected",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                    action: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                checkAll = !checkAll;
                              });
                              controller.checkAll(checkAll);
                            },
                            child: const Icon(Icons.checklist_rounded)),
                        if (controller.noteList
                            .where((e) => e.isCheck)
                            .isNotEmpty) ...[
                          10.hGap,
                          InkWell(
                              onTap: () {
                                controller.deleteNote();
                              },
                              child: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              )),
                        ]
                      ],
                    ),
                  )
                : CommonAppBar(
                    title: const Text(
                      "My Notes",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    drawerOnTap: () {
                      drawerController.toggleDrawer();
                    },
                    action: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(() => const NoteCreatePage());
                            },
                            child: const Icon(Icons.add)),
                      ],
                    ),
                  ),
            body: notes.isEmpty
                ? Center(child: Lottie.asset('assets/json/empty.json'))
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return InkWell(
                          onLongPress: () {
                            onLongPress = true;
                            setState(() {});
                            log("On Long Press");
                          },
                          onTap: () {
                            Get.to(() => NoteCreatePage(id: note.note.id));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: (100 + (index % 5) * 20).toDouble(),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _extractFirstLine(note.note.note ?? ""),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat.MMMMEEEEd()
                                            .format(note.note.createdAt!),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      if (onLongPress)
                                        InkWell(
                                          onTap: () {
                                            controller.onCheck(index);
                                          },
                                          child: Icon(
                                            note.isCheck
                                                ? Icons.check_circle
                                                : Icons.circle,
                                            color: note.isCheck
                                                ? Colors.amberAccent
                                                : Colors.black12,
                                          ),
                                        )
                                    ],
                                  ),
                                  2.vGap,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
          );
        });
  }

  String _extractFirstLine(String deltaJsonString) {
    final List<dynamic> deltaJson = jsonDecode(deltaJsonString);

    final doc = Document.fromJson(deltaJson);

    final fullText = doc.toPlainText();

    final firstLine = fullText.split('\n').first;

    return firstLine;
  }
}
