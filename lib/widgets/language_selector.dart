import 'package:flutter/material.dart';


void main() => runApp( const MaterialApp(home: Center(child: LanguageSelector(width: 50, height:50))));

class LanguageSelector extends StatefulWidget {

  final double width;
  final double height;

  const LanguageSelector({super.key, required this.width, required this.height});

  @override
  LanguageSelectorState createState() => LanguageSelectorState();
}

class LanguageSelectorState extends State<LanguageSelector> {
  String _selectedFlag = 'assets/icons/flags/US_flag.png';

  final List<Map<String, String>> _flags = [
    {'language': 'English (US)', 'path': 'assets/icons/flags/US_flag.png'},
    {'language': 'English (UK)', 'path': 'assets/icons/flags/UK_flag.png'},
    {'language': 'Spanish', 'path': 'assets/icons/flags/Spain_flag.png'},
    {'language': 'French', 'path': 'assets/icons/flags/France_flag.png'},
    {'language': 'German', 'path': 'assets/icons/flags/Germany_flag.png'},
    {'language': 'Italian', 'path': 'assets/icons/flags/Italy_flag.png'},
    {'language': 'Portuguese', 'path': 'assets/icons/flags/Portugal_flag.png'},
    {'language': 'Russian', 'path': 'assets/icons/flags/Russia_flag.png'},
    {'language': 'Chinese (Simplified)', 'path': 'assets/icons/flags/China_flag.png'},
    {'language': 'Chinese (Traditional)', 'path': 'assets/icons/flags/Taiwan_flag.png'},
    {'language': 'Japanese', 'path': 'assets/icons/flags/Japan_flag.png'},
    {'language': 'Korean', 'path': 'assets/icons/flags/Korea_flag.png'},
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _flags.sort((a, b) => a['language']!.compareTo(b['language']!));
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selected = await showMenu<Map<String, String>>(
          context: context,
          position: const RelativeRect.fromLTRB(100, 100, 100, 100),
          items: _flags.map((flag) {
            return PopupMenuItem<Map<String, String>>(
              value: flag,
              child: ListTile(
                leading: Image.asset(flag['path']!, width: 30, height: 30),
                title: Text(flag['language']!),
              ),
            );
          }).toList(),
        );

        if (selected != null) {
          setState(() {
            _selectedFlag = selected['path']!;
          });
        }
      },
      child: Image.asset(
        _selectedFlag,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}


