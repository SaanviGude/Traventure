/*import 'package:flutter/material.dart';
import 'package:flutter_basics/userprofile.dart';
import 'profile.dart';
import 'main.dart' ;

import 'package:firebase_auth/firebase_auth.dart';

class historys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDCD0A1), // Background color matching the design
        appBar: AppBar(
          backgroundColor: Color(0xFF4D8C53), // Green app bar color
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),color: Color(0xFFDCD0A1),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'HISTORY',
            style: TextStyle(
              fontFamily: 'Serif', // Matching font style from image
              fontSize: 28,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));// Add account navigation code here
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              FeedbackCard(
                imageUrl: 'backgroundimg.jpg', // Example image
                title: 'goa wonders',
                price: '25,000/-',
                date: '3 days | 29 sep',
              ),
              SizedBox(height: 16),
              FeedbackCard(
                imageUrl: 'backgroundimg.jpg', // Example image
                title: 'beaches',
                price: '25,000/-',
                date: '3 days | 29 sep',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String date;

  FeedbackCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), // Light cream color for card
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    imageUrl,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:flutter_basics/userprofile.dart';
import 'profile.dart';
import 'main.dart' ;

import 'package:firebase_auth/firebase_auth.dart';

class historys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDCD0A1), // Background color matching the design
        appBar: AppBar(
          backgroundColor: Color(0xFF4D8C53), // Green app bar color
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),color: Color(0xFFDCD0A1),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'HISTORY',
            style: TextStyle(
              fontFamily: 'Serif', // Matching font style from image
              fontSize: 28,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));// Add account navigation code here
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              FeedbackCard(
                imageUrl: 'backgroundimg.jpg', // Example image
                title: 'goa wonders',
                price: '25,000/-',
                date: '3 days | 29 sep',
              ),
              SizedBox(height: 16),
              FeedbackCard(
                imageUrl: 'backgroundimg.jpg', // Example image
                title: 'beaches',
                price: '25,000/-',
                date: '3 days | 29 sep',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String date;

  FeedbackCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), // Light cream color for card
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    imageUrl,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_basics/userprofile.dart';
import 'profile.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class HistoryScreen extends StatelessWidget {
  final String? userId;

  HistoryScreen({required this.userId});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDCD0A1),
        appBar: AppBar(
          backgroundColor: Color(0xFF4D8C53),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'HISTORY',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(userId: FirebaseAuth.instance.currentUser?.uid)),
                );
              },
            ),
          ],
        ),
        body: UserHistoryList(userId: FirebaseAuth.instance.currentUser?.uid),
      ),
    );
  }
}

class UserHistoryList extends StatelessWidget {
  final String? userId;

  UserHistoryList({this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('userlogin') // Replace with your actual collection name
            .doc(userId) // Get the document for the current user
            .collection('history') // Collection for user's history
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // If there's no data, show this message
            return Center(child: Text('No history available.'));
          }

          // Build a list of history items
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return FeedbackCard(
                imageUrl: data['imageUrl'] ?? 'backgroundimg.jpg', // Use image URL from Firestore
                title: data['packageName'] ?? 'Unknown Title',
                price: data['price'] ?? 0,
                date: data['date'] ?? 'Unknown Date',
              );
            },
          );
        },
      ),
    );
  }
}
//gs://flutter-basics-85cec.appspot.com/profile_images/8YeabT4QgTTTMH3X39DREn3EXFI2
//https://firebasestorage.googleapis.com/v0/b/flutter-basics-85cec.appspot.com/o/profile_images%2F8YeabT4QgTTTMH3X39DREn3EXFI2?alt=media&token=5ea59c8b-904b-4517-9acb-7d1e4ad44900
class FeedbackCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String date;

  FeedbackCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    imageUrl,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(height:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    //   SizedBox(height:10),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    Text(

                      price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),

                    ),


                  ],

                ),
              ],
            ),
            Align(

              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: TextStyle(color: Colors.black),
              ),
            ),

          ],
        ),
      ),

    );

  }

}
