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
        "Title:\n\n$title\n\nDescription$description\n\nTags:\n\n$tags";

    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent);
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

  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');

    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
