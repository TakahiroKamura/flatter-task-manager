import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import 'book_add.dart';
import 'book_list.dart';
import 'drawer_menu.dart';
import 'task_list.dart';

// ignore: must_be_immutable
class TopList extends StatefulWidget {
  const TopList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopList createState() => _TopList();
}

class _TopList extends State<TopList> {
  late List<String> labels;
  late List<BookState> bookList;
  late List<TaskState> taskList;
  late Widget body = const Center();

  _TopList() {
    init();
  }

  // ローカルデータベース
  final db = Localstore.instance;
  Map<String, dynamic>? saveData;

  // 現在のタブインデックス
  int currentIndex = 0;

  init() async {
    final Map<String, dynamic>? saveData =
        await db.collection('save').doc('data').get();
    if (saveData == null) {
      return {};
    }
    List<String> savedLabels = [];
    for (final String label in saveData['labels']) {
      savedLabels.add(label);
    }
    List<BookState> savedBookList = [];
    for (final BookState book in saveData['books']) {
      savedBookList.add(BookState(title: book.title, state: book.state));
    }
    List<TaskState> savedTaskList = [];
    for (final TaskState task in saveData['tasks']) {
      savedTaskList.add(TaskState(title: task.title, state: task.state));
    }

    labels = savedLabels;
    bookList = savedBookList;
    taskList = savedTaskList;
    body = BookList(labels: labels, bookList: bookList, taskList: taskList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブックマネージャー'),
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          Widget nextBody = const Center();
          if (value == 0) {
            nextBody = BookList(
                labels: labels, bookList: bookList, taskList: taskList);
          } else if (value == 1) {
            nextBody = TaskList(
                labels: labels, bookList: bookList, taskList: taskList);
          }
          setState(() {
            currentIndex = value;
            body = nextBody;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'タスク'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // pushで新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newBook = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return const BookAddPage();
            }),
          );
          if (newBook != null) {
            // キャンセルした場合はListtがnullとなるので注意
            setState(() {
              // リスト追加
              bookList.add(BookState(title: newBook, state: 0));
            });
            db.collection('save').doc('data').set({
              'labels': labels,
              'books': bookList,
              'tasks': taskList,
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class InitParams {
  InitParams(this.labels, this.bookList, this.taskList);

  List<String> labels;
  List<BookState> bookList;
  List<TaskState> taskList;
}
