import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class LanguageSelector extends StatefulWidget {
  final double width;
  final double height;
  final bool isNativeSelector;

  const LanguageSelector({
    super.key,
    required this.width,
    required this.height,
    this.isNativeSelector = false,
  });

  @override
  LanguageSelectorState createState() => LanguageSelectorState();
}

class LanguageSelectorState extends State<LanguageSelector> {
  late String _selectedFlag = '';

  final List<Map<String, String>> _flags = [
    {'language': 'English', 'path': 'assets/icons/flags/US_flag.png'},
    {'language': 'Spanish', 'path': 'assets/icons/flags/Spain_flag.png'},
    {'language': 'French', 'path': 'assets/icons/flags/France_flag.png'},
    {'language': 'German', 'path': 'assets/icons/flags/Germany_flag.png'},
    {'language': 'Italian', 'path': 'assets/icons/flags/Italy_flag.png'},
    {'language': 'Portuguese', 'path': 'assets/icons/flags/Brazil_flag.png'},
    {'language': 'Russian', 'path': 'assets/icons/flags/Russia_flag.png'},
    {
      'language': 'Chinese (Simplified)',
      'path': 'assets/icons/flags/China_flag.png'
    },
    {
      'language': 'Chinese (Traditional)',
      'path': 'assets/icons/flags/Taiwan_flag.png'
    },
    {'language': 'Japanese', 'path': 'assets/icons/flags/Japan_flag.png'},
    {'language': 'Korean', 'path': 'assets/icons/flags/Korea_flag.png'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeSelectedFlag();
  }

  Future<void> _initializeSelectedFlag() async {
  final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
  await languageProvider.loadPreferences();

    setState(() {
      _selectedFlag = widget.isNativeSelector
          ? _getFlagPath(languageProvider.nativeLanguage)
          : _getFlagPath(languageProvider.learningLanguage);
    });

}

  String _getFlagPath(String language) {
    return _flags.firstWhere((flag) => flag['language'] == language)['path']!;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final nativeLanguage = languageProvider.nativeLanguage;

    final filteredFlags = widget.isNativeSelector
        ? _flags
        : _flags.where((flag) => flag['language'] != nativeLanguage).toList();

    return GestureDetector(
      onTap: () async {
        final selected = await showMenu<Map<String, String>>(
          context: context,
          position: const RelativeRect.fromLTRB(100, 100, 100, 100),
          items: filteredFlags.map((flag) {
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

          if (widget.isNativeSelector) {
            languageProvider.setNativeLanguage(selected['language']!);
          } else {
            languageProvider.setLearningLanguage(selected['language']!);
          }
        }
      },
      child: _selectedFlag.isEmpty
          ? const CircularProgressIndicator()
          : Image.asset(
              _selectedFlag,
              width: widget.width,
              height: widget.height,
            ),
    );
  }
}
