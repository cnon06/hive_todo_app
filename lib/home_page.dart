import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive/hive.dart';
import 'package:hive_todo_app/data/local_storage.dart';
import 'package:hive_todo_app/main.dart';

import 'package:hive_todo_app/widgets/custom_search_delegate.dart';
import 'package:hive_todo_app/widgets/task_item.dart';

import 'models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final taskBox = Hive.box<Task>("taskf");

  
  final _localStorage = locator<LocalStorage>();

  Future<List<Task>> getData() async {
    return await _localStorage.getAllTask();
    
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'title',
          style: TextStyle(color: Colors.black),
        ).tr(),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                _showSearchPage();
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _showAddTaskBottomSheet();
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder<List<Task>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var allTasks = snapshot.data;

              
              return allTasks!.isNotEmpty
                  ? ListView.builder(
                      itemCount: allTasks.length,
                      itemBuilder: (context, index) {
                        final currentValue = allTasks[index];
                        return Dismissible(
                          background: ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text("remove_task").tr(),
                          ),
                          onDismissed: (direction) {
                            _localStorage.deleteTask(task: currentValue);
                            
                            setState(() {});
                          },
                          key: UniqueKey(), 
                          child: TaskItem(
                            index: index,
                            task: currentValue,
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                      "empty_task_list",
                      style: Theme.of(context).textTheme.headline5,
                    ).tr());
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: TextField(
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'add_task'.tr(),
                  border: InputBorder.none,
                ),
                onSubmitted: (name) {
                  
                  
                  
                  Navigator.pop(context);
                  if (name.trim() != "") {
                    DatePicker.showTimePicker(context,
                        locale:  setLocaleType(deviceLocale: context.deviceLocale.languageCode), 
                        showSecondsColumn: false, onConfirm: (time) {
                      var newWillBeAddedTask =
                          Task.create(name: name, createdAt: time);
                      debugPrint(newWillBeAddedTask.createdAt.toString());
                      _localStorage.addTask(
                          task: Task.create(name: name, createdAt: time));
                      
                      setState(() {});
                    });
                  }
                },
              ),
            ),
          );
        });
  }

  void _showSearchPage() async {
    List<Task> getTasks = await getData();
    showSearch(
        context: context,
        delegate: CustomSearchDelegate(
          taskList: getTasks,
        ));
  }

  dynamic setLocaleType({required dynamic deviceLocale}) {
    Map<String, dynamic> deviceLocaleMap = {
      "tr": LocaleType.tr,
      "en": LocaleType.en
    };
    return deviceLocaleMap[deviceLocale];
  }
}
