/*import 'package:flutter/material.dart';
import 'package:flutter_basics/userprofile.dart';
import 'profile.dart';
import 'main.dart' ;

class FeedbackScreen extends StatelessWidget {
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
            'FEED BACK',
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
                // Add account navigation code here
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
                title: 'goa wonders',
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
            SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'RATING',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
              ],
            ),
            Row(
              children: [
                Text(
                  'GUIDE RATING',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
              ],
            ),
            Row(
              children: [
                Text(
                  'LOCAL GUIDE RATING',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
                Icon(Icons.star_border, color: Colors.grey),
              ],
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'FEEDBACK',
                filled: true,
                fillColor: Color(0xFFC1C1C1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 8),
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class FeedbackScreen extends StatelessWidget {
  final String? userId;
 // final String packageId;
  FeedbackScreen({required this.userId,/* required this.packageId*/});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDCD0A1),
        appBar: AppBar(
          backgroundColor: Color(0xFF4D8C53),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'FEEDBACK',
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
                // Navigate to user profile or other actions
              },
            ),
          ],
        ),
        body: UserHistoryWithFeedback(userId: userId),
      ),
    );
  }
}

class UserHistoryWithFeedback extends StatelessWidget {
  final String? userId;

  UserHistoryWithFeedback({this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('userlogin') // Collection where user history is stored
            .doc(userId) // Document for the current user
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

          // Build a list of history items with feedback submission
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return FeedbackCardWithForm(
                historyItemId: snapshot.data!.docs[index].id,
                imageUrl: data['imageUrl'] ?? 'backgroundimg.jpg',
                title: data['packageName'] ?? 'Unknown Title',
                price: data['price'] ?? 0,
                date: data['date'] ?? 'Unknown Date',
                userId: userId,
                packageId:data['packageId'],
              );
            },
          );
        },
      ),
    );
  }
}

class FeedbackCardWithForm extends StatefulWidget {
  final String historyItemId;
  final String imageUrl;
  final String title;
  final double price;
  final String date;
  final String? userId;
  final String packageId;

  FeedbackCardWithForm({
    required this.historyItemId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.date,
    required this.userId,
    required this.packageId,
  });

  @override
  _FeedbackCardWithFormState createState() => _FeedbackCardWithFormState();
}

class _FeedbackCardWithFormState extends State<FeedbackCardWithForm> {
  // Controllers for feedback input
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  // Method to submit feedback
  Future<void> submitFeedback() async {
    if (widget.userId != null && feedbackController.text.isNotEmpty && ratingController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('userlogin')
          .doc(widget.userId)
          .collection('feedback') // Feedback collection under the specific history item
          .add({
        'feedback': feedbackController.text,
        'rating': ratingController.text,
        'date': DateTime.now().toString(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'packageId':widget.packageId,
      });
      await FirebaseFirestore.instance.collection('guidefeedback')
          // Feedback collection under the specific history item
          .add({
        'feedback': feedbackController.text,
        'rating': ratingController.text,
        'date': DateTime.now().toString(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'packageId':widget.packageId,
      });

      // Clear the input fields after submission
      feedbackController.clear();
      ratingController.clear();

      // Optionally show a message after successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted successfully!')),
      );
    } else {
      // Show an error message if inputs are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
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
                  child: Image.network(
                    widget.imageUrl,
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
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.date,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 12),

            // Feedback input section
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                filled: true,
                fillColor: Color(0xFFC1C1C1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 8),
            TextField(
              controller: ratingController,
              decoration: InputDecoration(
                labelText: 'Rating (out of 5)',
                filled: true,
                fillColor: Color(0xFFC1C1C1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),

            // Submit button
            ElevatedButton(
              onPressed: submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4D8C53),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text(
                'Submit Feedback',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
