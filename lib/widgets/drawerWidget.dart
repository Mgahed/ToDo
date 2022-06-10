import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/capitalize.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String _name = '';
  String _email = '';
  String _token = '';
  String _exp = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('_name') ?? '';
      _email = prefs.getString('_email') ?? '';
      _token = prefs.getString('_token') ?? '';
      _exp = prefs.getString('_exp') ?? '';
    });
    if (_token == '') {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            accountName: Text(_name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface)),
            accountEmail: Text(_email,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                _name[0].toUpperCase(),
                style: TextStyle(
                    fontSize: 40.0,
                    color: Theme.of(context).colorScheme.secondaryContainer),
              ),
            ),
          ),
          buildListTile(context, 'home'),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, route) {
    return ListTile(
      title: Text(capitalize(route)),
      leading: const Icon(Icons.home),
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/$route');
      },
      // textColor: Theme.of(context).indicatorColor,
    );
  }
}
