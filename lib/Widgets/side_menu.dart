import 'package:flutter/material.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/screens/profile_page.dart';
import 'package:seedling_app/screens/settings_page.dart';

void main() => runApp(MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: const SideMenu(),
      ),
    ));

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
                    backgroundImage:
                        AssetImage('assets/icons/flags/US_flag.png'),
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
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: null,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                // Navigate to the SettingsView
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SettingsView(showMenu: ValueNotifier<bool>(false))),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: Provider.of<ThemeNotifier>(context).isDarkMode,
              onChanged: (bool value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 300), child: Divider()),
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