import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class reset extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<reset> {
  final _idController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF235537).withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE4D59F),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'NEW PASSWORD:',
                    filled: true,
                    fillColor: Color(0xFFEEE2B3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'CONFIRM:',
                    filled: true,
                    fillColor: Color(0xFFEEE2B3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Firebase password reset logic
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: _idController.text.trim(), // Ensure this is the correct controller for email
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Password reset link sent! Check your email.'),
                      ));
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error: ${e.toString()}'),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE4D59F),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF235537),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Back button logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE4D59F),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  ),

                  child: Text(
                    'BACK',
                    style: TextStyle(color: Color(0xFF235537)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}