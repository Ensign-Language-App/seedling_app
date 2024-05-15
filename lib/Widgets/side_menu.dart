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
              color: Colors.lightGreen,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2eBwWNVsx4cmRUBRM9jip0fzz4rej8CmQ-Q&usqp=CAU'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Duo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ]),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: null,
          ),
          const Padding(padding: EdgeInsets.only(top: 350), child: Divider()),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: Scaffold(body: SideMenu())));
