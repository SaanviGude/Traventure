/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// Initialize Firebase in your main method


class GuideFeedbackPage extends StatelessWidget {
  final String? guideId;

  GuideFeedbackPage({required this.guideId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Feedback'),
      ),
);
  }
}

// Widget to fetch and display feedback list for the specific guide
class FeedbackList extends StatelessWidget {
  final String guideId;

  FeedbackList({required this.guideId});

  @override
  Widget build(BuildContext context) {
    // Reference to userLogin collection
    final CollectionReference userLoginCollection =
    FirebaseFirestore.instance.collection('userlogin');

    return StreamBuilder<QuerySnapshot>(
      // Fetch all userLogin documents and access their feedback sub-collections
      stream: userLoginCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Widget> feedbackWidgets = [];

        // Iterate through each user document
        for (var userDoc in snapshot.data!.docs) {
          final feedbackCollection = userDoc.reference.collection('feedback');

          feedbackCollection.where('guideId', isEqualTo: guideId).get().then((feedbackSnapshot) {
            if (feedbackSnapshot.docs.isNotEmpty) {
              for (var feedbackDoc in feedbackSnapshot.docs) {
                final data = feedbackDoc.data() as Map<String, dynamic>;
                final packageName = data['packageName'] ?? 'Unknown Package';
                final feedbackText = data['feedback'] ?? 'No feedback';

                feedbackWidgets.add(
                  PackageCard(packageName: packageName, feedback: feedbackText),
                );
              }
            }
          });
        }

        if (feedbackWidgets.isEmpty) {
          return Center(child: Text('No feedback available for this guide.'));
        }

        return ListView(
          children: feedbackWidgets,
        );
      },
    );
  }
}

// A widget to display individual package feedback
class PackageCard extends StatelessWidget {
  final String packageName;
  final String feedback;

  PackageCard({required this.packageName, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              packageName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Feedback: $feedback'),
          ],
        ),
      ),
    );
  }
}
*/

/*


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// Initialize Firebase in your main method

class GuideFeedbackPage extends StatelessWidget {
  final String? guideId;

  GuideFeedbackPage({required this.guideId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Feedback'),
      ),
      body: FeedbackList(guideId: guideId!),
    );
  }
}

// Widget to fetch and display feedback list for the specific guide
class FeedbackList extends StatelessWidget {
  final String guideId;

  FeedbackList({required this.guideId});

  @override
  Widget build(BuildContext context) {
    // Reference to userLogin collection
    final CollectionReference userLoginCollection =
    FirebaseFirestore.instance.collection('userlogin');

    return StreamBuilder<QuerySnapshot>(
      // Fetch all userLogin documents
      stream: userLoginCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Widget> feedbackWidgets = [];

        // Iterate through each user document
        for (var userDoc in snapshot.data!.docs) {
          feedbackWidgets.add(
            StreamBuilder<QuerySnapshot>(
              // Fetch the feedback sub-collection for each user document
              stream: userDoc.reference
                  .collection('feedback')
                  .where('guideId', isEqualTo: guideId)
                  .snapshots(),
              builder: (context, feedbackSnapshot) {
                if (feedbackSnapshot.hasError) {
                  return Center(child: Text('Error loading feedback.'));
                }

                if (feedbackSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (feedbackSnapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No feedback for this guide.'));
                }

                return Column(
                  children: feedbackSnapshot.data!.docs.map((feedbackDoc) {
                    final data = feedbackDoc.data() as Map<String, dynamic>;
                    final packageId = data['packageId'] ?? 'Unknown Package';
                    final feedbackText = data['feedback'] ?? 'No feedback';
                    final userIdText=data['userId'];

                    return PackageCard(
                        packageId: packageId, feedback: feedbackText,userId:userIdText);
                  }).toList(),
                );
              },
            ),
          );
        }

        if (feedbackWidgets.isEmpty) {
          return Center(child: Text('No feedback available for this guide.'));
        }

        return ListView(
          children: feedbackWidgets,
        );
      },
    );
  }
}

// A widget to display individual package feedback
class PackageCard extends StatelessWidget {
  final String packageId;
  final String feedback;
  final String userId;

  PackageCard({required this.packageId,required this.userId, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              packageId,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Feedback: $feedback'),
          ],
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class GuideFeedbackPage extends StatelessWidget {
  final String? guideId;

  GuideFeedbackPage({required this.guideId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF235537),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'GUIDE FEEDBACK',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: FeedbackList(guideId: guideId!),
    );
  }
}

class FeedbackList extends StatelessWidget {
  final String guideId;

  FeedbackList({required this.guideId});

  @override
  Widget build(BuildContext context) {
    final CollectionReference userLoginCollection =
    FirebaseFirestore.instance.collection('userlogin');

    return StreamBuilder<QuerySnapshot>(
      stream: userLoginCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Widget> feedbackWidgets = [];

        for (var userDoc in snapshot.data!.docs) {
          feedbackWidgets.add(
            StreamBuilder<QuerySnapshot>(
              stream: userDoc.reference
                  .collection('feedback')
                  .where('guideId', isEqualTo: guideId)
                  .snapshots(),
              builder: (context, feedbackSnapshot) {
                if (feedbackSnapshot.hasError) {
                  return Center(child: Text('Error loading feedback.'));
                }

                if (feedbackSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (feedbackSnapshot.data!.docs.isNotEmpty) {
                  return Column(
                    children: feedbackSnapshot.data!.docs.map((feedbackDoc) {
                      final data = feedbackDoc.data() as Map<String, dynamic>;
                      final packageId = data['packageId'] ?? 'Unknown Package';
                      final feedbackText = data['feedback'] ?? 'No feedback';
                      final userIdText = data['userId'];

                      return PackageCard(
                        packageId: packageId,
                        feedback: feedbackText,
                        userId: userIdText,
                      );
                    }).toList(),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          );
        }

        if (feedbackWidgets.isEmpty) {
          return Center(child: Text('No feedback available for this guide.'));
        }

        return ListView(
          children: feedbackWidgets,
        );
      },
    );
  }
}

class PackageCard extends StatelessWidget {
  final String packageId;
  final String feedback;
  final String userId;

  PackageCard({required this.packageId, required this.userId, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.card_travel, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Package ID: $packageId',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'User ID: $userId',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.feedback, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Feedback: $feedback',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
