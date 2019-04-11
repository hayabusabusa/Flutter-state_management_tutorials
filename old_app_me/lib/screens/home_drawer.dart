import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('ホームへ'),
            leading: Icon(Icons.arrow_forward_ios),
            onTap: () => {},
          ),
          Divider(height: 2.0),
          ListTile(
            title: Text('周辺情報'),
            leading: Icon(Icons.arrow_forward_ios),
            onTap: () => {},
          ),
          Divider(height: 2.0),
          ListTile(
            title: Text('入居情報'),
            leading: Icon(Icons.arrow_forward_ios),
            onTap: () => {},
          ),
          Divider(height: 2.0),
          ListTile(
            title: Text('料金情報'),
            leading: Icon(Icons.arrow_forward_ios),
            onTap: () => {},
          ),
          Divider(height: 2.0),
          ExpansionTile(
            title: Text('ゴミ出しカレンダー'),
            leading: Icon(Icons.arrow_forward_ios),
            children: <Widget>[
              Divider(height: 2.0),
              ListTile(title: Text('Child'))
            ],
          ),
          Divider(height: 2.0),
        ],
      ),
    );
  }
}