import 'package:book_manager/change_label.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 64,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'メニュー',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.description),
            title: Text('使い方'),
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('ラベル1を変更する'),
            onTap: () async {
              Navigator.pop(context, null);
              await showDialog(
                  context: context,
                  builder: (_) {
                    return ChangeLabel(titleName: 'ラベル1を変更する');
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('ラベル2を変更する'),
            onTap: () async {
              Navigator.pop(context, null);
              await showDialog(
                  context: context,
                  builder: (_) {
                    return ChangeLabel(titleName: 'ラベル2を変更する');
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('ラベル3を変更する'),
            onTap: () async {
              Navigator.pop(context, null);
              await showDialog(
                  context: context,
                  builder: (_) {
                    return ChangeLabel(titleName: 'ラベル3を変更する');
                  });
            },
          ),
          const ListTile(
              leading: Icon(Icons.subject), title: Text('プライバシーポリシー')),
          ListTile(
            leading: const Icon(Icons.flag),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('バージョン'),
                Text(
                  '1.0.0',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const ListTile(title: Text('Copyright 2022 PMK Games')),
        ],
      ),
    );
  }
}
