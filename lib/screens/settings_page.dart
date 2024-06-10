import 'package:flutter/material.dart' show AppBar, BuildContext, Icon, Icons, ListTile, ListView, MaterialApp, Scaffold, StatelessWidget, Text, ValueNotifier, Widget, runApp;

class SettingsView extends StatelessWidget {

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.subscriptions),
            title: Text('My Subscription'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('General'),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          ListTile(
            title: Text('Advance'),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('Delete or Suspend Account'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SettingsView(),
  ));
}