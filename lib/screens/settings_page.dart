import 'package:flutter/material.dart';
import 'package:seedling_app/screens/settings_screens.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('General'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GeneralPage()),
              );
            },
          ),
          const ListTile(
            title: Text('Advance'),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpSupportPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Delete or Suspend Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeleteAccountPage()), // Link to the new screen
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SettingsPage(),
  ));
}