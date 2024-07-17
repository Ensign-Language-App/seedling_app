import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/widgets/language_selector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/language_provider.dart';
import '../providers/progress_provider.dart';
import 'home_page.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'bookmark_page.dart';
import 'package:seedling_app/providers/color_provider.dart';

void main() => runApp(const MaterialApp(home: ProfilePage()));

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Future<double> _fetchProgress(BuildContext context) async {
  final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
  final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
  final learningLanguage = languageProvider.learningLanguage;
  return await progressProvider.getTotalProgress(context);
}

  Future<void> _showEditNameDialog(BuildContext context) async {
    final userController = Provider.of<UserController>(context, listen: false);
    final TextEditingController nameController = TextEditingController(
      text: userController.user?.displayName ?? '',
    );

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit User Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'New User Name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                await userController.updateUserName(nameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final user = userController.user;
    final colorProvider = Provider.of<ColorProvider>(context);

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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorProvider.gradientStartColor, colorProvider.gradientEndColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                        child: user?.photoURL == null
                            ? InkWell(
                          onTap: () async {
                            await userController.updateProfilePicture();
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 50,
                          ),
                        )
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LanguageSelector(
                          width: 50, height: 50, isNativeSelector: true),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            user?.displayName != null && user!.displayName!.length > 16
                                ? '${user.displayName!.substring(0, 16)}...'
                                : user?.displayName ?? 'User Name',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => _showEditNameDialog(context),
                          ),
                        ],
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
                        const LanguageSelector(
                            width: 40, height: 40, isNativeSelector: false),
                        const SizedBox(height: 15),
                        FutureBuilder<double>(
                          future: _fetchProgress(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error loading progress');
                            } else {
                              return LinearProgressIndicator(
                                value: snapshot.data ?? 0.0,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                              );
                            }
                          },
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
                        _socialIcon(FontAwesomeIcons.facebook, Colors.blue, 'https://www.facebook.com/'),
                        _socialIcon(FontAwesomeIcons.twitter, Colors.lightBlue, 'https://twitter.com/'),
                        _socialIcon(FontAwesomeIcons.instagram, Colors.pink, 'https://www.instagram.com/'),
                        _socialIcon(FontAwesomeIcons.youtube, Colors.red, 'https://www.youtube.com/'),
                      ],
                    ),
                  ),
                  _buildSection(
                    'Bookmark',
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.heart, color: Colors.red, size: 30),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BookmarkPage()));
                      },
                    ),
                  ),
                  _buildSection('Bookmark',
                      child: IconButton(
                          icon: const Icon(FontAwesomeIcons.heart,
                              color: Colors.red, size: 30),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BookmarkPage(),
                                ));
                          })),
                  _buildSection(
                    'Practice',
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.book,
                          color: Colors.lightGreen, size: 30),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
