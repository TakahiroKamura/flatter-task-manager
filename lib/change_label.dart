import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

// ignore: must_be_immutable
class ChangeLabel extends StatelessWidget {
  String titleName = '';
  String labelName = '';

  final db = Localstore.instance;

  ChangeLabel({super.key, required this.titleName});

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
              TextField(
                onChanged: (String value) => {
                  labelName = value,
                },
              ),
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
                    if (labelName != '') {
                      db.collection('save').doc('data').set({
                        titleName: labelName,
                      });
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, labelName);
                  },
                  child: const Text('変更')),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 140,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: const Text('キャンセル')),
            ),
          ],
        ),
      ],
    );
  }
}
