import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  _ContactSupportPageState createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _emailSent = false;

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

  Future<void> _sendEmail(String name, String message) async {
    final String email = 'luispencerg@gmail.com';
    final String subject = 'Support Request';
    final String body = 'Name: $name\n\n$message';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    try {
      if (await canLaunch(emailUri.toString())) {
        await launch(emailUri.toString());
        setState(() {
          _emailSent = true;
        });
      } else {
        throw 'Could not launch email app';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).canvasColor;
    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedGradientBackground(),
          _buildFormContainer(context, backgroundColor),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildAnimatedGradientBackground() {
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFFff964f), Color(0xFFFFF3B0)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              transform: GradientRotation(_animation.value * 3.14 * 2),
            ),
          ),
          child: child,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * .11, left: 75),
        child: const Text(
          'Contact Support',
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
      padding: EdgeInsets.only(top: screenHeight * .19),
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
            children: [
              SizedBox(height: screenHeight * .025),
              _buildTextField(_nameController, 'Your Name', Icons.person, false),
              SizedBox(height: screenHeight * .02),
              _buildTextField(_messageController, 'Your Message', Icons.message, false, maxLines: 5),
              SizedBox(height: screenHeight * .02),
              _buildSendEmailButton(),
              if (_emailSent) ...[
                const Center(
                  child: Text(
                    'Your message has been sent. Thank you for reaching out to us!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      IconData icon, bool obscureText, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: Icon(icon, color: Colors.grey),
        label: Text(
          labelText,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFFff964f)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSendEmailButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.email),
      label: const Text('Send Email'),
      onPressed: () {
        _sendEmail(_nameController.text, _messageController.text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFff964f),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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