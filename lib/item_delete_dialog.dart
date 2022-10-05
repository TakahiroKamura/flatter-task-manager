import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

// ignore: must_be_immutable
class ItemDeleteDialog extends StatelessWidget {
  String titleName = '';

  final db = Localstore.instance;

  ItemDeleteDialog({super.key, required this.titleName});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(titleName),
        ],
      ),
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text('$titleNameを削除してもよいですか？'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              width: 140,
              child: ElevatedButton(
                  onPressed: () async {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                  },
                  child: const Text('削除する')),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 140,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('キャンセル')),
            ),
          ],
        ),
      ],
    );
  }
}
