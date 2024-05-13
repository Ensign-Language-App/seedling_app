import 'package:flutter/material.dart';
import 'package:seedling_app/screens/log_in_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const ListTile(
            title: Text('Profile'),
            onTap: null,
          ),
          const ListTile(
            title: Text('About'),
            onTap: null,
          ),
          const Divider(),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogInPage()),
              );
            },
          )
        ],
      ),
    );
  }
}


void main() => runApp(const MaterialApp(home:Scaffold(body:SideMenu())));
