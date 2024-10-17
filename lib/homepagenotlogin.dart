import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_basics/helpdesk.dart';
import 'profile.dart';
import 'notprofile.dart';
import 'main.dart';
import 'userprofile.dart';

class noHomePage extends StatelessWidget {
  final String userId;
  noHomePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5E8953),
        title: Text('Traventure', style: TextStyle(color: Color(0xFFDCD0A1))),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(Icons.search),
            color: Color(0xFFDCD0A1),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoProfilePage(userId: userId)),
              );
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('packages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No packages available.'));
          }

          final packages = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index].data() as Map<String, dynamic>;
                return TripCard(
                  name: package['name'],
                  price: package['price'], // Now int
                  days: package['days'],
                  rating: package['rating'],
                  description: package['description'],
                  imageUrl: package['image'],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFFBF6DF),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.history, size: 50),
                  title: Text('History', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NoProfilePage(userId: userId)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.feedback_outlined, size: 50),
                  title: Text('Feedback', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NoProfilePage(userId: userId)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, size: 50),
                  title: Text('Settings', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help_center, size: 50),
                  title: Text('Help desk', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => helpdesk()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined, size: 50),
                  title: Text('Log In', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/images/Traventurelogo1.png',
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final String name;
  final int price; // Changed to int
  final String days;
  final String rating;
  final String description;
  final String? imageUrl;

  TripCard({
    required this.name,
    required this.price,
    required this.days,
    required this.rating,
    required this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              imageUrl ?? 'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '$price/-', // Updated price display
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 5),
                Text(
                  '$days days',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 5),
                    Text(rating, style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('packages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No packages found.'));
        }

        final results = snapshot.data!.docs.where((DocumentSnapshot package) {
          final packageName = (package.data() as Map<String, dynamic>)['name'].toLowerCase();
          return packageName.contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final package = results[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(package['name']),
              onTap: () {
                close(context, null); // Handle result selection here
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('packages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final suggestions = snapshot.data!.docs.where((DocumentSnapshot package) {
          final packageName = (package.data() as Map<String, dynamic>)['name'].toLowerCase();
          return packageName.contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final package = suggestions[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(package['name']),
              onTap: () {
                query = package['name'];
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
