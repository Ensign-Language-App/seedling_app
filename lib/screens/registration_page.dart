import 'package:flutter/material.dart';
import 'package:seedling_app/screens/home_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> showingAccountCreationSheet = ValueNotifier(false);
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _reEnteredPasswordController = TextEditingController();

    bool _isFirstNameValid = true;
    bool _isLastNameValid = true;
    bool _isUsernameValid = true;
    bool _isEmailValid = true;
    bool _isPasswordValid = true;
    bool _isReEnteredPasswordValid = true;

    bool _usernameExists = false;
    bool _emailExists = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your account'),
        actions: [
          IconButton(
            onPressed: () {
              showingAccountCreationSheet.value = false;
              _resetFields();
            },
            icon: const Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: () {
              if (!_usernameExists && !_emailExists) {
                _addAccount();
                showingAccountCreationSheet.value = false;
              }
              _resetFields();
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
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: 'First Name',
              hintText: 'Enter your first name',
            ),
            onChanged: (value) {
              _isFirstNameValid = value.trim().isNotEmpty && RegExp(r'^[a-zA-Z]+$').hasMatch(value);
            },
          ),
          if (!_isFirstNameValid)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'First name can only contain letters.',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              hintText: 'Enter your last name',
            ),
            onChanged: (value) {
              _isLastNameValid = value.trim().isNotEmpty && RegExp(r'^[a-zA-Z]+$').hasMatch(value);
            },
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: _userNameController,
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
            controller: _emailController,
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
            controller: _passwordController,
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
            controller: _reEnteredPasswordController,
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

  void _resetFields() {
    // Reset all fields
  }

  void _addAccount() {
    // Add account logic
  }


}

void main() {
  runApp(const MaterialApp(home: RegistrationPage()));
}