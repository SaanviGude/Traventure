import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset.dart';
import 'main.dart';
void main() {
  runApp(MyApp());
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _idController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  //final _newPasswordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();
// Function to send password reset email

  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _idController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent. Check your inbox.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  'FORGOT PASSWORD',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF3E5B5),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'email id:',
                    filled: true,
                    fillColor: Color(0xFFEEE2B3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _resetPassword();
                    // Submit logic
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => reset()),
                    );*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE4D59F),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 75),
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