import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import 'package:seedling_app/screens/profile_page.dart';
import 'package:seedling_app/screens/settings_page.dart';
import 'package:seedling_app/providers/theme_notifier.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    ImageProvider<Object> userImage;
    if (userController.user?.photoURL != null &&
        userController.user!.photoURL!.isNotEmpty) {
      userImage = NetworkImage(userController.user!.photoURL!);
    } else {
      userImage = const AssetImage('assets/images/default_icon.jpg');
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.lightGreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  foregroundImage: userImage,
                ),
                const SizedBox(height: 10),
                Text(
                  userController.user?.displayName ?? 'Guest',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Consumer<ThemeNotifier>(
              builder: (context, theme, child) {
                return Switch(
                  value: theme.isDarkMode,
                  onChanged: (bool value) {
                    theme.toggleTheme();
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              await userController.signOut();
              if (mounted) {
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
