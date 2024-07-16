import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Import the color picker package
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:seedling_app/providers/color_provider.dart';

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