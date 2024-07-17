import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import 'package:seedling_app/screens/ContactSupportPage.dart';
import 'package:seedling_app/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/user_controller.dart';
import '../providers/color_provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Future<void> _openAppSettings() async {
    await openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<NotificationService>(context);
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Stack(
        children: [
          _buildAnimatedGradientBackground(context, colorProvider),
          _buildContent(context, notificationService),
        ],
      ),
    );
  }

  Widget _buildAnimatedGradientBackground(BuildContext context, ColorProvider colorProvider) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: colorProvider,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorProvider.gradientStartColor, colorProvider.gradientEndColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: child,
        );
      },
      child: Container(),
    );
  }

  Widget _buildContent(BuildContext context, NotificationService notificationService) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manage Notifications',
            style: TextStyle(fontSize: 22, color: Colors.white,
                fontWeight: FontWeight.bold),


          ),
          const SizedBox(height: 40),
          const Text(
            'Enable or disable notifications',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              final status = await notificationService.checkPermissions();
              if (status.isDenied || status.isPermanentlyDenied) {
                await notificationService.requestPermissions();
              } else {
                await _openAppSettings();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Open Notification Settings'),
          ),
        ],
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

        ],
      ),
    );
  }
}
class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _agreedToTerms = false;

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
          _buildAnimatedGradientBackground(context, colorProvider),
          _buildFormContainer(context, backgroundColor),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildAnimatedGradientBackground(BuildContext context, ColorProvider colorProvider) {
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
        padding: EdgeInsets.only(top: screenHeight * .09, left: 70),
        child: const Text(
          'Help and Support',
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
      padding: EdgeInsets.only(top: screenHeight * .17),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .025),
              _buildSectionTitle('About the App'),
              const Text(
                'Our app is designed to help users improve their vocabulary in various languages. Whether you are a beginner or an advanced learner, our app provides a comprehensive platform to learn and remember words of every kind. With a focus on practical usage, the app helps users to expand their vocabulary through engaging and interactive methods.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * .02),
              _buildSectionTitle('Terms and Conditions'),
              const Text(
                'By using this app, you agree to our terms and conditions. The app is intended for personal use only. Users are responsible for maintaining the confidentiality of their account information and for all activities that occur under their account. The app developers are not liable for any loss or damage arising from the use of the app. We reserve the right to modify these terms at any time, and such modifications will be effective immediately upon posting the modified terms within the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * .02),
              _buildTermsCheckbox(),
              SizedBox(height: screenHeight * .02),
              _buildSectionTitle('Support'),
              const Text(
                'If you need any assistance or have any questions about the app, please feel free to reach out to our support team. We are here to help you with any issues or concerns you may have.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * .02),
              _buildContactSupportButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreedToTerms,
          onChanged: (bool? value) {
            setState(() {
              _agreedToTerms = value ?? false;
            });
          },
        ),
        const Expanded(
          child: Text(
            'I agree to the terms and conditions.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSupportButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.email),
      label: const Text('Contact Support'),
      onPressed: _agreedToTerms
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactSupportPage(),
          ),
        );
      }
          : null,
      style: ElevatedButton.styleFrom(
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        backgroundColor: const Color(0xFFff964f),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
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
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
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
    final colorProvider = Provider.of<ColorProvider>(context);
    final backgroundColor = Theme.of(context).canvasColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
      ),
      body: Stack(
        children: [
          _buildAnimatedGradientBackground(context, colorProvider),
          _buildFormContainer(context, backgroundColor),
        ],
      ),
    );
  }

  Widget _buildAnimatedGradientBackground(BuildContext context, ColorProvider colorProvider) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: colorProvider,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorProvider.gradientStartColor, colorProvider.gradientEndColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: child,
        );
      },
      child: Container(),
    );
  }

  Widget _buildFormContainer(BuildContext context, Color backgroundColor) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * .10),
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
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Do you want to delete your account?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'This action is irreversible and all your data will be permanently deleted.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _confirmDelete(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Delete Account',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}