import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/widgets/language_selector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'bookmark_page.dart';
import 'package:seedling_app/providers/color_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
        home: const ProfilePage(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final user = userController.user;
    final backgroundColor = Provider.of<ColorProvider>(context).backgroundColor;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: backgroundColor,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : const AssetImage('assets/images/default_icon.jpg')
                    as ImageProvider,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LanguageSelector(width: 50, height: 50),
                      const SizedBox(height: 10),
                      Text(
                        user?.displayName ?? 'User Name',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Current Learning Path',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LanguageSelector(width: 40, height: 40),
                        const SizedBox(height: 15),
                        LinearProgressIndicator(
                          value: 0.4,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  _buildSection(
                    'Achievements',
                    child: const Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.amber, size: 30),
                        SizedBox(width: 10),
                        Icon(Icons.military_tech, color: Colors.grey, size: 30),
                      ],
                    ),
                  ),
                  _buildSection(
                    'Social Media',
                    child: Row(
                      children: [
                        _socialIcon(FontAwesomeIcons.facebook, Colors.blue,
                            'https://www.facebook.com/'),
                        _socialIcon(FontAwesomeIcons.twitter, Colors.lightBlue,
                            'https://twitter.com/'),
                        _socialIcon(FontAwesomeIcons.instagram, Colors.pink,
                            'https://www.instagram.com/'),
                        _socialIcon(FontAwesomeIcons.youtube, Colors.red,
                            'https://www.youtube.com/'),
                      ],
                    ),
                  ),
                  _buildSection(
                      'Bookmark',
                      child: IconButton(
                          icon: const Icon(FontAwesomeIcons.heart, color: Colors.red,
                              size: 30),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => const BookmarkPage(),
                                ));
                          })
                  ),
                  _buildSection(
                    'Practice',
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.book, color: Colors.lightGreen,
                          size: 30),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, {required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        child,
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _socialIcon(IconData icon, Color color, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: IconButton(
        icon: Icon(icon, color: color, size: 30),
        onPressed: () => _launchURL(url),
      ),
    );
  }
}