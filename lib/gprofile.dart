import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_basics/editgprofile.dart'; // Import Firestore

class GProfilePage extends StatefulWidget {
  final String? userId; // Pass the user ID to the page

  GProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<GProfilePage> {
  late Future<Map<String, dynamic>?> userData;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      userData = fetchUserData(widget.userId!);
    } else {
      // Handle case where userId is null, e.g. assign an empty future
      userData = Future.value(null);
    }
  }

  // Function to fetch user data from Firestore
  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('guides')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        return null; // No data found
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/AppHS.jpeg', // Path to your image
                fit: BoxFit.cover, // Make the image cover the entire background
              ),
            ),
            // Your content on top of the background
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Color(0xFF315E3C),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text(
                      'PROFILE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Arial',
                        letterSpacing: 2.0,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FutureBuilder<Map<String, dynamic>?>(
                          future: userData, // Fetch user data
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loader
                            } else if (snapshot.hasError) {
                              return Text('Error fetching data');
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return Text('No user data found');
                            } else {
                              var data = snapshot.data!;
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    // Display profile image if available
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: data['imageUrl'] != null && data['imageUrl'] != ""
                                          ? NetworkImage(data['imageUrl']) // Display profile image
                                          : null,
                                      child: data['imageUrl'] == null || data['imageUrl'] == ""
                                          ? Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.black,
                                      )
                                          : null, // Show default icon if no image
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'GUIDE-ID: ${widget.userId}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Arial',
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Details:',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Arial',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    _buildDetailRow(Icons.person, data['name'] ?? 'No name'),
                                    _buildDetailRow(Icons.phone, data['phone'] ?? 'No phone'),
                                    _buildDetailRow(Icons.perm_identity, data['aadhaar'] ?? 'No AID'),
                                    _buildDetailRow(Icons.location_on, data['address'] ?? 'No address'),
                                    _buildDetailRow(Icons.email, data['email'] ?? 'No email'),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditGuideProfile(userId: widget.userId),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF315F3C), // Button color
                                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        'EDIT',
                                        style: TextStyle(
                                          color: Color(0xFFFDEAB2),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each row of the details section
  Widget _buildDetailRow(IconData icon, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.black,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              detail,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
