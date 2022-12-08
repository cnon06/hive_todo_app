// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  // ignore: constant_identifier_names
  static const Map<String,dynamic> en_US = {
  "title": "What will you today?",
  "empty_task_list": "Come on, Add a task.",
  "add_task": "What is the task?",
  "remove_task": "This task was deleted."
};
// ignore: constant_identifier_names
static const Map<String,dynamic> tr_TR = {
  "title": "Bugün neler yapacaksın?",
  "empty_task_list": "Hadi bir görev ekle.",
  "add_task": "Görev Nedir?",
  "remove_task": "Bu görev silindi."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US, "tr_TR": tr_TR};
}
