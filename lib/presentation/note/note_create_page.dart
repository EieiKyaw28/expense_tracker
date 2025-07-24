import 'dart:convert';
import 'dart:developer';

import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class NoteCreatePage extends StatefulWidget {
  const NoteCreatePage({
    super.key,
    this.id,
  });
  final int? id;

  @override
  State<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  QuillController _controller = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _fetchForNoteById();
    }
  }

  void _fetchForNoteById() {
    final noteController = Get.find<NoteController>();
    noteController.getNoteById(widget.id ?? 0).then((note) {
      if (note != null) {
        log("Note: ${note.note}");
        _controller = QuillController(
          document: Document.fromJson(jsonDecode(note.note ?? '[]')),
          selection: const TextSelection.collapsed(offset: 0),
        );
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _editorScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    log("Note id : ${widget.id}");

    return CommonScaffold(
      appBar: const CommonAppBar(
        hasDrawer: false,
        title: Text(
          "Create Note",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.primaryColor,
        onPressed: () {
          final noteJson = _controller.document.toDelta().toJson();

          noteController.addNote(jsonEncode(noteJson));
        },
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Divider(thickness: .5, color: Colors.grey),
            QuillSimpleToolbar(
              controller: _controller,
              config: const QuillSimpleToolbarConfig(
                multiRowsDisplay: true,
                showDividers: true,

                // ✅ Text formatting
                showFontSize: true,
                showBoldButton: true,
                showItalicButton: false,
                showUnderLineButton: false,
                showSmallButton: false,

                // ✅ Lists
                showListBullets: true,
                showListCheck: true,
                showListNumbers: false,

                // ✅ Colors
                showColorButton: true,
                showClipboardPaste: false,

                // ❌ Turn off all others
                showFontFamily: false,

                showAlignmentButtons: false,
                showCenterAlignment: false,
                showCodeBlock: false,
                showDirection: false,
                showHeaderStyle: false,
                showIndent: false,
                showInlineCode: false,
                showLink: false,
                showQuote: false,
                showSearchButton: false,
                showStrikeThrough: false,
                showClearFormat: false,
                showBackgroundColorButton: false,
                showJustifyAlignment: false,
                showLeftAlignment: false,
                showRightAlignment: false,
                showRedo: false,
                showUndo: false,
                showSubscript: false,
                showSuperscript: false,

                //embedButtons: FlutterQuillEmbeds.toolbarButtons(),
              ),
            ),
            QuillEditor(
              focusNode: _editorFocusNode,
              scrollController: _editorScrollController,
              controller: _controller,
              config: const QuillEditorConfig(
                placeholder: 'Start writing your notes...',
                padding: EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
