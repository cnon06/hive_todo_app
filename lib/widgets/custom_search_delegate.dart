import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_todo_app/home_page.dart';
import 'package:hive_todo_app/widgets/task_item.dart';

import '../data/local_storage.dart';
import '../main.dart';
import '../models/task_model.dart';


class CustomSearchDelegate extends SearchDelegate {
  final List<Task> taskList;
 

  CustomSearchDelegate({required this.taskList});
  final _localStorage = locator<LocalStorage>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const HomePage())));
        },
        icon: const Icon(
          Icons.arrow_back_ios,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> filteredList = taskList
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    
    return filteredList != [] ? ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return Dismissible(
              background: ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("remove_task").tr(),
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                _localStorage.deleteTask(task: filteredList[index]);
           
              },
              child: TaskItem(task: filteredList[index], index: index));
        }) : Center(child: Text("search_not_found", style: Theme.of(context).textTheme.headline5,).tr());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
