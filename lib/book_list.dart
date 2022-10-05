import 'package:book_manager/item_delete_dialog.dart';
import 'package:book_manager/task_list.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

// ignore: must_be_immutable
class BookList extends StatefulWidget {
  List<String> labels;
  List<BookState> bookList;
  List<TaskState> taskList;

  BookList(
      {super.key,
      required this.labels,
      required this.bookList,
      required this.taskList});

  @override
  // ignore: library_private_types_in_public_api
  _BookList createState() => _BookList();
}

class _BookList extends State<BookList> {
  final db = Localstore.instance;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.bookList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            int state = widget.bookList[index].state;
            state++;
            if (state > 2) {
              state = 0;
            }
            setState(() {
              widget.bookList[index].state = state;
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
                      titleName: widget.bookList[index].title);
                });
            if (tap) {
              widget.bookList.removeAt(index);
              setState(() {
                widget.bookList = widget.bookList;
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
                      Text(widget.bookList[index].title,
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                // タグ
                Container(
                  padding: const EdgeInsets.all(4),
                  child: BookTags(
                      state: widget.bookList[index].state,
                      labels: widget.labels),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BookTags extends StatelessWidget {
  const BookTags({super.key, required this.state, required this.labels});

  final int state;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: labels.asMap().entries.map((entry) {
          return BookTag(
              bookTag: entry.value,
              isActive: state == entry.key ? true : false);
        }).toList());
  }
}

// ignore: must_be_immutable
class BookTag extends StatelessWidget {
  final String bookTag;
  final bool isActive;

  const BookTag({super.key, required this.bookTag, required this.isActive});

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
            bookTag,
            style: TextStyle(
                fontSize: 16, color: isActive ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}

class BookState {
  BookState({
    this.title = '',
    this.state = 0,
  });

  String title;
  int state;

  dynamic toJson() => {'title': title, 'state': state};
}
