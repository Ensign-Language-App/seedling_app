import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Import the color picker package
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:seedling_app/providers/color_provider.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import '../controllers/user_controller.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('Notifications Settings'),
      ),
    );
  }
}

class GeneralPage extends StatelessWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Settings'),
      ),
      body: ListView(
        children: [
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
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Background Color'),
            trailing: IconButton(
              icon: const Icon(Icons.palette),
              onPressed: () async {
                Color? selectedColor = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Background Color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: Colors.blue,
                        onColorChanged: (color) {
                          Provider.of<ColorProvider>(context, listen: false)
                              .setBackgroundColor(color);
                          Navigator.of(context).pop(color);
                        },
                      ),
                    ),
                  ),
                );
                if (selectedColor != null) {
                  Provider.of<ColorProvider>(context, listen: false)
                      .setBackgroundColor(selectedColor);
                }
              },
            ),
          ),
          // Add other general settings here
        ],
      ),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About and Support'),
      ),
      body: const Center(
        child: Text('Help & Support Information'),
      ),
    );
  }
}
class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  Future<void> _confirmDelete(BuildContext context) async {
    final bool? confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete your account? This action is irreversible.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false when cancel is pressed
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true when delete is pressed
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await Provider.of<UserController>(context, listen: false).deleteAccount(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LogInPage()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Increased padding for more formality
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure you want to delete your account?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Increased font size for more formality
            ),
            const SizedBox(height: 20),
            const Text(
              'This action is irreversible and all your data will be permanently deleted.',
              style: TextStyle(fontSize: 18), // Increased font size for more formality
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _confirmDelete(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set the button color to red
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Added padding to the button
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.white), // Set the text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}