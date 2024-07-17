import 'package:flutter/material.dart';
import 'package:seedling_app/screens/settings_screens.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:seedling_app/providers/color_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final backgroundColor = Theme.of(context).canvasColor;

    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedGradientBackground(colorProvider),
          _buildFormContainer(context, backgroundColor),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildAnimatedGradientBackground(ColorProvider colorProvider) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorProvider.gradientStartColor, colorProvider.gradientEndColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              transform: GradientRotation(_animation.value * 3.14 * 2),
            ),
          ),
          child: child,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * .09, left: 100),
        child: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFormContainer(BuildContext context, Color backgroundColor) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * .18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: backgroundColor,
        ),
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          children: [
            SizedBox(height: screenHeight * .025),
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
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('About & Support'),
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
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16, // Adjust the position based on the status bar height
      left: 16,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
      ],
      child: const MaterialApp(
        home: SettingsPage(),
      ),
    ),
  );
}