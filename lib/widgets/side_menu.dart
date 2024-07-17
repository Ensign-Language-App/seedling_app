// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilities/biometric_auth.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import 'package:seedling_app/screens/profile_page.dart';
import 'package:seedling_app/screens/settings_page.dart';
import 'package:seedling_app/screens/settings_screens.dart';
import 'package:seedling_app/providers/color_provider.dart';

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
    final backgroundColor = Provider.of<ColorProvider>(context).backgroundColor;

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
            decoration: BoxDecoration(
              color: backgroundColor,
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            // TODO: CANT FIND THE ERROR... I THINK IT'S IN THE USER_CONTROLLER
            onTap: () async {
              await userController.signOut();
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