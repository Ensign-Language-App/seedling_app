import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(
      const MaterialApp(
        home: ProfilePage(),
      ),
    );

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.lightGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/default_icon.jpg'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CountryFlag.fromCountryCode(
                        'CA',
                        height: 60,
                        width: 90,
                        borderRadius: 10,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'User Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 105,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.lightGreen, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Current Learning Path:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              CountryFlag.fromCountryCode(
                                'FR',
                                height: 30,
                                width: 45,
                                borderRadius: 5,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 270,
                            height: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: 0.4,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.lightGreen),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 105,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.lightGreen, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Achievements',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.emoji_events,
                                color: Colors.amber, size: 50),
                            SizedBox(width: 10),
                            Stack(
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.grey, size: 50),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Icon(Icons.military_tech,
                                      color: Colors.white, size: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 105,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.lightGreen, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Social Media',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(FontAwesomeIcons.facebook,
                                    color: Colors.blue, size: 40),
                                Icon(FontAwesomeIcons.twitter,
                                    color: Colors.lightBlue, size: 40),
                                Icon(FontAwesomeIcons.instagram,
                                    color: Colors.pink, size: 40),
                                Icon(FontAwesomeIcons.youtube,
                                    color: Colors.red, size: 40),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 160,
                          height: 105,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.lightGreen, width: 3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Favorites',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.list,
                                    color: Colors.lightGreen, size: 40),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 165,
                          height: 105,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.lightGreen, width: 3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Practice',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(FontAwesomeIcons.book,
                                    color: Colors.lightGreen, size: 30),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
