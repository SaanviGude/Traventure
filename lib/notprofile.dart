import 'package:flutter/material.dart';
import 'main.dart';

class NoProfilePage extends StatelessWidget {
  final String? userId; // Variable to hold the userId
  NoProfilePage({required this.userId}); // Constructor to receive userId

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          ' PROFILE',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF255A39),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile image section
                CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('assets/images/profile-user.png'), // Placeholder image
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 25),

                // Card-like container for profile information and actions
                Container(
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE4D3A2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // "No Profile Found" Text
                      Text(
                        'USER NOT FOUND',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 3),

                      // User ID
                      Text(
                        'ID: $userId',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Login button with similar styling to the Profile page
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF255A39),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ],
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
