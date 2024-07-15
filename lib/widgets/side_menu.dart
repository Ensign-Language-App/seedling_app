// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilities/biometric_auth.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import 'package:seedling_app/screens/profile_page.dart';
import 'package:seedling_app/screens/settings_page.dart';
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:seedling_app/screens/settings_screens.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  final BiometricAuth biometricAuth = BiometricAuth();

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
              color: Color.fromRGBO(255, 150, 79, 1.0),
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
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SettingsPage()),
              // );

              bool isAuthenticated = await biometricAuth.authenticate();
              if (!mounted) return;

              if (isAuthenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Authentication failed')),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsPage()),
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
              await userController.signOut(context);
              if (mounted) {
                Navigator.pushReplacement(
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
