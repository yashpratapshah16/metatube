import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metatube/utils/snackbar_utils.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldNotEmpty = false;

  File? _selectedFile;
  String _selectedDirectory = '';

  void saveContent(dynamic context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;

    final textContent =
        "Title:\n\n$title\n\nDescription\n\n$description\n\nTags:\n\n$tags";

    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent);
        SnackbarUtils.showSnackbar(
          context,
          Icons.check_circle,
          "File saved successfully.",
        );
      } else {
        final todayDate = getTodayDate();
        String metadataDirPath = _selectedDirectory;

        if (metadataDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metadataDirPath = directory!;
        }
        final filePath = '$metadataDirPath/$todayDate - $title - Metadata.txt';
        final newFile = File(filePath);
        await newFile.writeAsString(textContent);
        SnackbarUtils.showSnackbar(
          context,
          Icons.check_circle,
          "File saved successfully.",
        );
      }
    } catch (e) {
      SnackbarUtils.showSnackbar(
        context,
        Icons.error,
        "File not saved!",
      );
    }
  }

  void loadFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    try {
      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;

        final fileContent = await file.readAsString();

        final lines = fileContent.split('\n\n');
        titleController.text = lines[1];
        descriptionController.text = lines[3];
        tagsController.text = lines[5];

        SnackbarUtils.showSnackbar(
          context,
          Icons.upload_file,
          "File uploaded.",
        );
      } else {
        SnackbarUtils.showSnackbar(
          context,
          Icons.error_rounded,
          "File not Selected!",
        );
      }
    } catch (e) {
      SnackbarUtils.showSnackbar(
        context,
        Icons.error_rounded,
        "File not Selected!",
      );
    }
  }

  void newFile(context) {
    _selectedFile = null;
    titleController.clear();
    tagsController.clear();
    descriptionController.clear();
    SnackbarUtils.showSnackbar(context, Icons.file_open, "New file created!");
  }

  void newDirectory(context) async {
    try {
      String? directory = await FilePicker.platform.getDirectoryPath();
      _selectedDirectory = directory!;
      _selectedFile = null;
      SnackbarUtils.showSnackbar(
        context,
        Icons.folder,
        "New folder selected.",
      );
    } catch (e) {
      SnackbarUtils.showSnackbar(
        context,
        Icons.error_rounded,
        "No folder selected!",
      );
    }
  }

  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');

    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
