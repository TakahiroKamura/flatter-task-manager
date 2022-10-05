import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import 'book_list.dart';
import 'task_list.dart';
import 'top_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = Localstore.instance;

  if (await db.collection('save').doc('data').get() == null) {
    await db.collection('save').doc('data').set({
      'labels': ['学校', '鞄', '家'],
      'books': [
        BookState(title: '国語', state: 0),
        BookState(title: '数学', state: 0),
        BookState(title: '英語', state: 0),
      ],
      'tasks': [
        TaskState(title: '遊ぶ', state: 0),
        TaskState(title: '寝る', state: 1),
        TaskState(title: '食べる', state: 2),
      ],
    });
  }

  runApp(const BookManager());
}

// ルートWidget
class BookManager extends StatelessWidget {
  const BookManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ブックマネージャー',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TopList(),
    );
  }
}
