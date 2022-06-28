import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrttodo/widgets/snackBar.dart';

import '../api/auth.dart';
import '../controller/themeController.dart';
import '../functions/capitalize.dart';
import '../functions/checkAuth.dart';
import '../functions/prefs.dart';
import '../theme/my_theme.dart';

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
    getDataPrefs().then((value) {
      setState(() {
        _name = value['_name'] ?? '';
        _email = value['_email'] ?? '';
        _token = value['_token'] ?? '';
        _exp = value['_exp'] ?? '';
      });
      if (_token == '') {
        Get.offNamed('/login');
      }
      checkUser(context, _token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController _themeController = Get.find();
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
          buildListTile(context, 'profile'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            secondary: _themeController.isDarkMode.value
                ? const Icon(Icons.brightness_2)
                : const Icon(Icons.brightness_7),
            activeColor: Theme.of(context).colorScheme.primary,
            value: _themeController.isDarkMode.value,
            onChanged: (value) {
              setState(() {
                _themeController.isDarkMode.value = value;
              });
              _themeController.setDarkMode(value);
              print(_themeController.isDarkMode.value);
              Get.changeTheme(value
                  ? ThemeData(colorScheme: darkTheme)
                  : ThemeData(colorScheme: lightTheme));
              // Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () {
              logout(_token).then((response) {
                if (response["status"]) {
                  Get.offNamed('/login');
                }
                final snackBar = customSnackBar(response["message"], "ok");
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, route) {
    return ListTile(
      title: Text(capitalize(route)),
      leading:
          route == 'home' ? const Icon(Icons.home) : const Icon(Icons.person),
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/$route');
      },
      // textColor: Theme.of(context).indicatorColor,
    );
  }
}
