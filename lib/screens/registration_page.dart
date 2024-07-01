import 'package:flutter/material.dart';
import 'package:seedling_app/screens/language_selection_page.dart';
import '../utilities/firestore_service.dart';

void main() => runApp(const MaterialApp(home: RegistrationPage()));

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reEnteredPasswordController =
      TextEditingController();

  bool isFirstNameValid = true;
  bool isLastNameValid = true;
  bool isUsernameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isReEnteredPasswordValid = true;

  bool usernameExists = false;
  bool emailExists = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your account'),
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: _validateAndSubmit,
            icon: const Icon(Icons.done),
            disabledColor: Colors.grey,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(30.0),
              children: [
                //TODO: MAKE UNICODE NAME AVAILABLE
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Enter your first name',
                    errorText: isFirstNameValid
                        ? null
                        : 'First name can only contain letters.',
                  ),
                  onChanged: (value) {
                    setState(() {
                      isFirstNameValid = value.trim().isNotEmpty &&
                          RegExp(r'^[a-zA-Z]+$').hasMatch(value);
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  //TODO: MAKE UNICODE NAME AVAILABLE
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter your last name',
                    errorText: isLastNameValid
                        ? null
                        : 'Last name can only contain letters.',
                  ),
                  onChanged: (value) {
                    setState(() {
                      isLastNameValid = value.trim().isNotEmpty &&
                          RegExp(r'^[a-zA-Z]+$').hasMatch(value);
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  //TODO: USERNAME VALIDATION?
                  controller: userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Choose a username',
                  ),
                  onChanged: (value) {
                    setState(() {
                      setState(() {
                        isUsernameValid = value.trim().isNotEmpty &&
                                RegExp(r'^[a-zA-Z]+$').hasMatch(value) ||
                            RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
                      });
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  //TODO: IMPLEMENT EMAIL VALIDATION LOGIC?
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                  ),
                  onChanged: (value) {
                    setState(() {
                      isEmailValid = value.trim().isNotEmpty &&
                          RegExp(r'^@.+$').hasMatch(value);
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  //TODO: IMPLEMENT PASSWORD VALIDATION LOGIC?
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter a strong password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      isPasswordValid = value.trim().isNotEmpty &&
                              RegExp(r'^[a-zA-Z]+$').hasMatch(value) ||
                          RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  //TODO: IMPLEMENT RE-ENTER PASSWORD VALIDATION LOGIC?
                  controller: reEnteredPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Re-enter Password',
                    hintText: 'Re-enter your password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      isReEnteredPasswordValid =
                          value.trim() == passwordController.text;
                    });
                  },
                ),
              ],
            ),
    );
  }

  void _resetFields() {
    firstNameController.clear();
    lastNameController.clear();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    reEnteredPasswordController.clear();
    setState(() {
      isFirstNameValid = true;
      isLastNameValid = true;
      isUsernameValid = true;
      isEmailValid = true;
      isPasswordValid = true;
      isReEnteredPasswordValid = true;
    });
  }

  void _validateAndSubmit() async {
    setState(() {
      isFirstNameValid = firstNameController.text.trim().isNotEmpty &&
          RegExp(r'^[a-zA-Z]+$').hasMatch(firstNameController.text);
      isLastNameValid = lastNameController.text.trim().isNotEmpty &&
          RegExp(r'^[a-zA-Z]+$').hasMatch(lastNameController.text);
      isUsernameValid = userNameController.text.trim().isNotEmpty;
      isEmailValid = emailController.text.trim().isNotEmpty &&
          RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text);
      isPasswordValid = passwordController.text.trim().isNotEmpty &&
          passwordController.text.length >= 6;
      isReEnteredPasswordValid =
          passwordController.text == reEnteredPasswordController.text;
    });

    if (isFirstNameValid &&
        isLastNameValid &&
        isUsernameValid &&
        isEmailValid &&
        isPasswordValid &&
        isReEnteredPasswordValid) {
      setState(() {
        isLoading = true;
      });

      FirestoreService.saveUser(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          userNameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim());
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LanguagesSelectionPage(),
    ));
  }
}
