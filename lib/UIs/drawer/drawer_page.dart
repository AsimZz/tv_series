import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/blocs/user_info_bloc/user_info_bloc.dart';

class DrawerPage extends StatefulWidget {
  final String username;
  DrawerPage({Key key, this.username}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
  );
  @override
  Widget build(BuildContext context) {
    print(widget.username);
    return Drawer(
        child: _drawerList(
      widget.username,
    ));
  }

  Widget _drawerList(String username) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF7E061A),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Color(0xFF9E1F28),
            ),
            child: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(username, style: _textStyle),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'about_us',
              style: _textStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ), 
            title: Text(
              'settings',
              style: _textStyle,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
