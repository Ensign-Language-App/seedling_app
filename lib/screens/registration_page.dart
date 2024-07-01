import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'package:seedling_app/screens/log_in_page.dart';

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
  final TextEditingController reEnteredPasswordController = TextEditingController();

  bool isFirstNameValid = true;
  bool isLastNameValid = true;
  bool isUsernameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isReEnteredPasswordValid = true;

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
                    RegExp(r'^[\p{L}\p{M}]+$', unicode: true).hasMatch(value);
              });
            },
          ),
          const SizedBox(height: 15.0),
          // TODO: SET UP THE WARNING HERE
          TextFormField(
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
                    RegExp(r'^[\p{L}\p{M}]+$', unicode: true).hasMatch(value);
              });
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
              setState(() {
                isUsernameValid = value.trim().isNotEmpty &&
                    RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
              });
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
              setState(() {
                isEmailValid = value.trim().isNotEmpty &&
                    RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value);
              });
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
              setState(() {
                isPasswordValid = value.trim().isNotEmpty &&
                    value.length >= 8 &&
                    RegExp(r'[0-9]').hasMatch(value) &&
                    RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
              });
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
    // TODO: SET UP THE LOGIC HERE
    setState(() {
      isFirstNameValid = firstNameController.text.trim().isNotEmpty &&
          RegExp(r'^[\p{L}\p{M}]+$', unicode: true)
              .hasMatch(firstNameController.text);
      isLastNameValid = lastNameController.text.trim().isNotEmpty &&
          RegExp(r'^[\p{L}\p{M}]+$', unicode: true)
              .hasMatch(lastNameController.text);
      isUsernameValid = userNameController.text.trim().isNotEmpty;
      isEmailValid = emailController.text.trim().isNotEmpty &&
          RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(emailController.text);
      isPasswordValid = passwordController.text.trim().isNotEmpty &&
          passwordController.text.length >= 8 &&
          RegExp(r'[0-9]').hasMatch(passwordController.text) &&
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(passwordController.text);
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

      try {
        final userController = Provider.of<UserController>(context, listen: false);
        await userController.registerWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
          firstNameController.text.trim(),
          lastNameController.text.trim(),
        );

        // TODO: WAIT FOR THE LANGUAGE SELECTION PAGE TO BE READY
        // Navigate to the language selection page
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const LanguagesSelectionPage(),
        // ));

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LogInPage(),
        ));

      } on FirebaseAuthException catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
