import 'package:flutter/material.dart';

class BookAddPage extends StatefulWidget {
  const BookAddPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookAddPageState createState() => _BookAddPageState();
}

// リスト追加画面用Widget
class _BookAddPageState extends State<BookAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブックを追加'),
      ),
      body: Container(
        // 余白を付ける
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // テキスト入力
            TextField(
              // 入力されたテキストの値を受け取る(valueが入力されたテキスト)
              onChanged: (String value) {
                // データを変更
                _text = value;
              },
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              color: Colors.white,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
                  // popで前の画面に戻る
                  // popの引数から前の画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: const Text(
                  'ブックを追加',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              color: Colors.white,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // popで前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: const Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
