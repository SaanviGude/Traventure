/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart';
class helpdesk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDCD0A1), // Background color matching the design
        appBar: AppBar(
          backgroundColor: Color(0xFF235537), // Green app bar color
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'HELP DESK',
            style: TextStyle(
              fontFamily: 'Serif', // Font style to match design
              fontSize: 28,
              color: Color(0xFFF3E5B5),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF), // Light cream color for the box
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'WRITE YOUR PROBLEM',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.message, color: Colors.black),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'TYPE HERE',
                        filled: true,
                        fillColor: Color(0xFFDCD0A1), // Textfield background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Clear action
                          },
                          child: Text('CLEAR'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF000000), // Black button color
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Submit action
                          },
                          child: Text('SUBMIT'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF000000), // Black button color
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFF3E5B5), // Background color for phone icon
                child: Icon(Icons.phone, size: 40, color: Color(0xFF6A754C)), // Phone icon
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call Us action
                },
                child: Text(
                  'CALL US',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF3E5B5), // Light cream button color
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For Instagram Icon
import 'package:url_launcher/url_launcher.dart'; // For launching external links (Instagram, Call, Email)
import 'profile.dart';

class helpdesk extends StatelessWidget {
  final String instagramUrl = 'https://www.instagram.com/saanvigude_04_/profilecard/?igsh=aHg1d2J6amZ2NGQ1'; // Replace with your Instagram profile link
  final String phoneNumber = '9623044012'; // Replace with your 10-digit phone number
  final String email = 'saanvigude04@gmail.com'; // Replace with your helpdesk email

  // Method to launch Instagram profile
  void _launchInstagram() async {
    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }

  // Method to initiate phone call
  void _makePhoneCall() async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }

  // Method to initiate email
  void _sendEmail() async {
    final url = 'mailto:$email?subject=Help%20Request';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not send email to $email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDCD0A1), // Background color matching the design
        appBar: AppBar(
          backgroundColor: Color(0xFF235537), // Green app bar color
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'HELP DESK',
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 28,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // About Us Section
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ABOUT US',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'We are passionate about providing unforgettable travel experiences. Our mission is to offer curated travel packages tailored to your preferences. Whether you seek adventure, relaxation, or cultural immersion, we have the perfect trip for you.',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Our Motto: Explore the world with ease.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Creators:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                      Text('1. Krutika Amonkar'),
                      Text('2. Saanvi Gude'),
                      Text('3. Sahana Bhat'),
                      SizedBox(height: 15),
                      Center(
                        child: GestureDetector(
                          onTap: _launchInstagram,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(FontAwesomeIcons.instagram, color: Colors.black, size: 28),
                              SizedBox(width: 10),
                              Text(
                                'Follow us on Instagram',
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // Help Desk Section
                Container(
                  width: 300, // Ensures a square shape
                  height: 200,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF), // Light cream color for the box
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            ' HELP DESK',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.support_agent, color: Colors.black , size: 30),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _makePhoneCall,
                                child: CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.phone, size: 32, color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'CALL',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _sendEmail,
                                child: CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.email, size: 32, color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'EMAIL',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
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

