import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/screens/language_selection_page.dart';
import 'package:seedling_app/utilities/auth.dart';
import 'package:seedling_app/controllers/user_controller.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> showingAccountCreationSheet =
        ValueNotifier(false);
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController reEnteredPasswordController =
        TextEditingController();

    bool isFirstNameValid = true;
    bool isLastNameValid = true;
    // bool isUsernameValid = true;
    // bool isEmailValid = true;
    // bool isPasswordValid = true;
    // bool isReEnteredPasswordValid = true;

    bool usernameExists = false;
    bool emailExists = false;

    // Clears input of all fields
    void resetFields() {
      firstNameController.clear();
      lastNameController.clear();
      userNameController.clear();
      emailController.clear();
      passwordController.clear();
      reEnteredPasswordController.clear();
    }

    // This needs to be filled out more
    // Error checks and makeing shure it actually works
    Future<void> addAccount() async {
      final userController =
          Provider.of<UserController>(context, listen: false);
      await userController.registerWithEmailAndPassword('email', 'password');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your account'),
        actions: [
          IconButton(
            onPressed: () {
              showingAccountCreationSheet.value = false;
              resetFields();
            },
            icon: const Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: () {
              if (!usernameExists && !emailExists) {
                addAccount();
                showingAccountCreationSheet.value = false;
              }
              resetFields();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LanguagesSelectionPage()));
            },
            icon: const Icon(Icons.done),
            disabledColor: Colors.grey,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              labelText: 'First Name',
              hintText: 'Enter your first name',
            ),
            onChanged: (value) {
              isFirstNameValid = value.trim().isNotEmpty &&
                  RegExp(r'^[a-zA-Z]+$').hasMatch(value);
            },
          ),
          if (!isFirstNameValid)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'First name can only contain letters.',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              hintText: 'Enter your last name',
            ),
            onChanged: (value) {
              isLastNameValid = value.trim().isNotEmpty &&
                  RegExp(r'^[a-zA-Z]+$').hasMatch(value);
            },
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: userNameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Choose a username',
            ),
            onChanged: (value) {
              // Add validation logic for username
            },
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email address',
            ),
            onChanged: (value) {
              // Add validation logic for email
            },
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter a strong password',
            ),
            onChanged: (value) {
              // Add validation logic for password
            },
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: reEnteredPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Re-enter Password',
              hintText: 'Re-enter your password',
            ),
            onChanged: (value) {
              // Add validation logic for re-entered password
            },
          ),
          // Additional validation messages can be added similar to the first name field
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: RegistrationPage()));
}
