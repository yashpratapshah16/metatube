import 'package:flutter/material.dart';
import 'package:metatube/services/file_service.dart';
import 'package:metatube/utils/app_styles.dart';
import 'package:metatube/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FileService fileService=FileService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => null, "New File"),
                Row(
                  children: [
                    _actionButton(() => null, Icons.file_upload),
                    SizedBox(
                      width: 6,
                    ),
                    _actionButton(() => null, Icons.folder),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextfield(
              maxLines: 3,
              maxLength: 100,
              hintText: "Enter Video Title",
              controller: fileService.titleController,
            ),
            SizedBox(
              height: 40,
            ),
            CustomTextfield(
              maxLines: 6,
              maxLength: 5000,
              hintText: "Enter Video Description",
              controller: fileService.descriptionController,
            ),
            SizedBox(
              height: 40,
            ),
            CustomTextfield(
              maxLines: 4,
              maxLength: 500,
              hintText: "Enter Video Tags",
              controller: fileService.tagsController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                _mainButton(() => null, "Save File"),
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  Material _actionButton(Function()? onPressed, IconData icon) {
    return Material(
      color: Colors.transparent,
      type: MaterialType.circle,
      clipBehavior: Clip.antiAlias,
      borderOnForeground: true,
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        splashColor: AppTheme.accent,
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Icon(
            size: 30,
            icon,
            color: AppTheme.medium,
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
