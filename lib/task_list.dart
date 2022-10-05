import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import 'book_list.dart';
import 'item_delete_dialog.dart';

// ignore: must_be_immutable
class TaskList extends StatefulWidget {
  late List<String> labels;
  late List<BookState> bookList;
  late List<TaskState> taskList;

  TaskList(
      {super.key,
      required this.labels,
      required this.bookList,
      required this.taskList});

  @override
  // ignore: library_private_types_in_public_api
  _TaskList createState() => _TaskList();
}

class _TaskList extends State<TaskList> {
  int currentIndex = 1;

  final db = Localstore.instance;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.taskList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            int state = widget.taskList[index].state;
            state++;
            if (state > 2) {
              state = 0;
            }
            setState(() {
              widget.taskList[index].state = state;
            });
            db.collection('save').doc('data').set({
              'labels': widget.labels,
              'books': widget.bookList,
              'tasks': widget.taskList,
            });
          },
          onLongPress: () async {
            bool tap = await showDialog(
                context: context,
                builder: (_) {
                  return ItemDeleteDialog(
                      titleName: widget.taskList[index].title);
                });
            if (tap) {
              widget.taskList.removeAt(index);
              setState(() {
                widget.taskList = widget.taskList;
              });
            }
          },
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 30,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.taskList[index].title,
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                // タグ
                Container(
                    padding: const EdgeInsets.all(4),
                    child: TaskTags(state: widget.taskList[index].state)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TaskTags extends StatelessWidget {
  TaskTags({super.key, required this.state});

  final int state;
  final List<String> labels = ['Do', 'Doing', 'Done'];

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: labels.asMap().entries.map((entry) {
          return TaskTag(
              taskTag: entry.value,
              isActive: state == entry.key ? true : false);
        }).toList());
  }
}

// ignore: must_be_immutable
class TaskTag extends StatelessWidget {
  final String taskTag;
  final bool isActive;

  const TaskTag({super.key, required this.taskTag, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(2),
      ),
      width: 100,
      height: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            taskTag,
            style: TextStyle(
                fontSize: 16, color: isActive ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}

class TaskState {
  TaskState({
    this.title = '',
    this.state = 0,
    this.deadLine = '',
  });

  String title;
  int state;
  String deadLine;

  dynamic toJson() => {'title': title, 'state': state};
}
