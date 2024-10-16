import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editprofile.dart'; // Import the EditProfile page

class ProfilePage extends StatefulWidget {
  final String? userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>?> userData;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      userData = fetchUserData(widget.userId!);
    } else {
      userData = Future.value(null);
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('userlogin')
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
                'assets/images/AppHS.jpeg',
                fit: BoxFit.cover,
              ),
            ),
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
                          future: userData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error fetching data');
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return Text('No user data found');
                            } else {
                              var data = snapshot.data!;
                              return Container(
                                width: 350,
                                height: 600,
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[300],
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'USER-ID: ${widget.userId}',
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
                                    _buildDetailRow(
                                      Icons.location_on,
                                      data['address'] ?? 'No address',
                                    ),
                                    _buildDetailRow(Icons.email, data['email'] ?? 'No email'),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditProfile(userId: widget.userId),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF315F3C),
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

