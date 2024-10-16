/*

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_basics/gprofile.dart';
import 'package:flutter_basics/guideprofile.dart';
import 'package:flutter_basics/main.dart';
import 'dart:io'; // For handling files
import 'package:image_picker/image_picker.dart'; // For picking images
import 'profile.dart';
import 'feed.dart';
import 'history.dart';

import 'package_detail.dart';
import 'addpackage.dart';
import 'helpdesk.dart';
class GHomePage extends StatefulWidget {
  final String? selectedSearch;
  final String userId;
  GHomePage({this.selectedSearch,required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GHomePage> {
  File? _image; // To store the selected image
  final picker = ImagePicker();

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(

        leading: Row(
          children:[



     Builder(
    builder: (context) {
    return IconButton(
    icon: const Icon(Icons.menu), color: Color(0xFFDCD0A1),
    onPressed: () {
    Scaffold.of(context)
        .openDrawer(); // Open the drawer when tapped
    },
    );
    },
    ),
      ],
    ),
        backgroundColor: Color(0xFF5E8953),
        actions: <Widget>[

          IconButton(
            onPressed: () async {
              // Fetch the package names before showing the search
              List<String> packageNames = await _fetchPackageNames();

              // Pass the package names to the search delegate
              final result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchTerms: packageNames),
              );

              if (result != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GHomePage(selectedSearch: result, userId: widget.userId),
                  ),
                );
              }
            },
            icon: Icon(Icons.search, size: 30),
            color: Color(0xFFDCD0A1),
          ),
          IconButton(
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));

              },
            icon: const Icon(Icons.account_circle_sharp, size: 30),
            color: Color(0xFFDCD0A1),
          ),
        ],
        title: Text(
            'guide homepage',
          overflow:TextOverflow.ellipsis
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFFFBF6DF),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage, // Tap to pick an image
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _image != null
                            ? FileImage(_image!) // Display selected image
                            : AssetImage(
                            'assets/default_profile.png') as ImageProvider,
                        // Default image
                        child: _image == null
                            ? Icon(
                          Icons.camera_alt, size: 30, color: Colors.white,)
                            : null, // Show camera icon if no image
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.plus_one_outlined, size: 50),
                    title: Text(
                      'PACKAGE',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddPackagePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback_outlined, size: 50),
                    title: const Text('Feedback',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FeedbackScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, size: 50),
                    title: const Text('Settings',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => GProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help_center, size: 50),
                    title: const Text('Help desk',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => helpdesk()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined, size: 50),
                    title: const Text('Log Out',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,)),
                    onTap: () {
                      _logout(context); // Call the log-out function
                    },
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'images/Traventurelogo1.png',
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchPackages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No packages found.'));
          }
          final tripPackages = snapshot.data!;
          final filteredPackages = widget.selectedSearch != null
              ?
          tripPackages.where((package) =>
              package['name']!.toLowerCase().contains(
                  widget.selectedSearch!.toLowerCase()))
              .toList()
              : tripPackages;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredPackages.length,
              itemBuilder: (context, index) {
                var trip = filteredPackages[index];

                // Use null-aware operator to provide default values in case any field is null
                return TripCard(
                  image: trip['image'] ?? 'https://via.placeholder.com/150',  // Default image if null
                  name: trip['name'] ?? 'Unknown',                            // Default name if null
                  price: trip['price'] ?? 'N/A',                              // Default price if null
                  days: trip['days'] ?? '0',                                  // Default days if null
                  rating: trip['rating'] ?? '0',                              // Default rating if null
                  description: trip['description'] ?? 'No description available', // Default description if null
                );
              },
            ),
          );

       /* return Padding(

            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),

              itemCount: filteredPackages.length,
              itemBuilder: (context, index) {
                var trip = filteredPackages[index];
                return TripCard(
                  image: trip['image']!,
                  name: trip['name']!,
                  price: trip['price']!,
                  days: trip['days']!,
                  rating: trip['rating']!,
                  description: trip['description']!,
                );
              },
            ),
          );*/
        },
      ),
    );
  }

}


class TripCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String days;
  final String rating;
  final String description;


  const TripCard({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.days,
    required this.rating,
    required this.description

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to package detail page on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetailPage(
              image: image,
              title: name,
              price: price,
              days: days,
              rating: rating,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        child:Container(
           decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFEFEFEE),
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
                'https://via.placeholder.com/150',
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
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    days,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 5),
                      Text(
                        rating,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    ), ),
    );
  }
}
/*
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'goa wonders',
    'hidden gem',
    'sunset',
    'beaches',
    'Old goa',
    'Sight seeing',
    'small packages',
    'trekking',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFE1C767), // Custom background color of the search bar
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.black, // Search text color
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black), // Hint text color
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black, // Cursor color in the search box
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.green, // Change the text color of the result
              fontWeight: FontWeight.bold,
            ),
          ),
          tileColor: Colors.white, // Change the background color of the result item
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.black, // Change the text color of the suggestion
            ),
          ),
          tileColor: Color(0xFFEEE2B3), // Change the background color of the suggestion item
          onTap: () {
            close(context, result); // Close search and return the selected result
          },
        );
      },
    );
  }
}*/


void _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase (if using Firebase)

    // After logging out, navigate back to login or splash screen
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()) ); // Adjust route name as per your app's navigation
  } catch (e) {
    print('Error logging out: $e');
  }
}
Future<List<Map<String, dynamic>>> _fetchPackages() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('packages').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  } catch (e) {
    throw Exception('Failed to load packages: $e');
  }
}



class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchTerms;

  CustomSearchDelegate({required this.searchTerms});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFE1C767), // Custom background color of the search bar
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.black, // Search text color
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black), // Hint text color
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black, // Cursor color in the search box
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.green, // Change the text color of the result
              fontWeight: FontWeight.bold,
            ),
          ),
          tileColor: Colors.white, // Change the background color of the result item
          onTap: () {
            close(context, result); // Select the search result and close search
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.black, // Change the text color of the suggestion
            ),
          ),
          tileColor: Color(0xFFEEE2B3), // Change the background color of the suggestion item
          onTap: () {
            close(context, result); // Close search and return the selected result
          },
        );
      },
    );
  }
}

Future<List<String>> _fetchPackageNames() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('packages').get();
    return snapshot.docs.map((doc) => doc['name'].toString()).toList();
  } catch (e) {
    throw Exception('Failed to load package names: $e');
  }
}//1st code
*/



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_basics/gprofile.dart';
import 'package:flutter_basics/guideprofile.dart';
import 'package:flutter_basics/main.dart';
import 'dart:io'; // For handling files
import 'package:image_picker/image_picker.dart'; // For picking images
import 'profile.dart';
import 'feed.dart';
import 'history.dart';

import 'package_detail.dart';
import 'addpackage.dart';
import 'helpdesk.dart';
class GHomePage extends StatefulWidget {
  final String? selectedSearch;
  final String userId;
  GHomePage({this.selectedSearch,required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GHomePage> {
  File? _image; // To store the selected image
  final picker = ImagePicker();

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(

        leading: Row(
          children:[



            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu), color: Color(0xFFDCD0A1),
                  onPressed: () {
                    Scaffold.of(context)
                        .openDrawer(); // Open the drawer when tapped
                  },
                );
              },
            ),
          ],
        ),
        backgroundColor: Color(0xFF5E8953),
        actions: <Widget>[

          IconButton(
            onPressed: () async {
              // Fetch the package names before showing the search
              List<String> packageNames = await _fetchPackageNames();

              // Pass the package names to the search delegate
              final result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchTerms: packageNames),
              );

              if (result != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GHomePage(selectedSearch: result, userId: widget.userId),
                  ),
                );
              }
            },
            icon: Icon(Icons.search, size: 30),
            color: Color(0xFFDCD0A1),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));

            },
            icon: const Icon(Icons.account_circle_sharp, size: 30),
            color: Color(0xFFDCD0A1),
          ),
        ],
        title: Text(
            'guide homepage',
            overflow:TextOverflow.ellipsis
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFFFBF6DF),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage, // Tap to pick an image
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _image != null
                            ? FileImage(_image!) // Display selected image
                            : AssetImage(
                            'assets/default_profile.png') as ImageProvider,
                        // Default image
                        child: _image == null
                            ? Icon(
                          Icons.camera_alt, size: 30, color: Colors.white,)
                            : null, // Show camera icon if no image
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.plus_one_outlined, size: 50),
                    title: Text(
                      'PACKAGE',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddPackagePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback_outlined, size: 50),
                    title: const Text('Feedback',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FeedbackScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, size: 50),
                    title: const Text('Settings',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => GProfilePage(userId: FirebaseAuth.instance.currentUser?.uid,)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help_center, size: 50),
                    title: const Text('Help desk',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => helpdesk()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined, size: 50),
                    title: const Text('Log Out',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,)),
                    onTap: () {
                      _logout(context); // Call the log-out function
                    },
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'images/Traventurelogo1.png',
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchPackages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No packages found.'));
          }
          final tripPackages = snapshot.data!;
          final filteredPackages = widget.selectedSearch != null
              ?
          tripPackages.where((package) =>
              package['name']!.toLowerCase().contains(
                  widget.selectedSearch!.toLowerCase()))
              .toList()
              : tripPackages;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredPackages.length,
              itemBuilder: (context, index) {
                var trip = filteredPackages[index];

                // Use null-aware operator to provide default values in case any field is null
                return TripCard(
                  image: trip['image'] ?? 'https://via.placeholder.com/150',  // Default image if null
                  name: trip['name'] ?? 'Unknown',                            // Default name if null
                  price: trip['price'] ?? 'N/A',                              // Default price if null
                  days: trip['days'] ?? '0',                                  // Default days if null
                  rating: trip['rating'] ?? '0',                              // Default rating if null
                  description: trip['description'] ?? 'No description available', // Default description if null
                );
              },
            ),
          );

          /* return Padding(

            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),

              itemCount: filteredPackages.length,
              itemBuilder: (context, index) {
                var trip = filteredPackages[index];
                return TripCard(
                  image: trip['image']!,
                  name: trip['name']!,
                  price: trip['price']!,
                  days: trip['days']!,
                  rating: trip['rating']!,
                  description: trip['description']!,
                );
              },
            ),
          );*/
        },
      ),
    );
  }

}


class TripCard extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final String days;
  final String rating;
  final String description;


  const TripCard({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.days,
    required this.rating,
    required this.description

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to package detail page on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetailPage(
              image: image,
              title: name,
              price: price,
              days: days,
              rating: rating,
              description: description,
              userId: FirebaseAuth.instance.currentUser?.uid,
            ),
          ),
        );
      },
      child: Card(
        child:Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFEFEFEE),
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
                  'https://via.placeholder.com/150',
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
                      price.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      days,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 5),
                        Text(
                          rating,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ), ),
    );
  }
}
/*
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'goa wonders',
    'hidden gem',
    'sunset',
    'beaches',
    'Old goa',
    'Sight seeing',
    'small packages',
    'trekking',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFE1C767), // Custom background color of the search bar
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.black, // Search text color
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black), // Hint text color
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black, // Cursor color in the search box
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.green, // Change the text color of the result
              fontWeight: FontWeight.bold,
            ),
          ),
          tileColor: Colors.white, // Change the background color of the result item
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.black, // Change the text color of the suggestion
            ),
          ),
          tileColor: Color(0xFFEEE2B3), // Change the background color of the suggestion item
          onTap: () {
            close(context, result); // Close search and return the selected result
          },
        );
      },
    );
  }
}*/


void _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase (if using Firebase)

    // After logging out, navigate back to login or splash screen
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()) ); // Adjust route name as per your app's navigation
  } catch (e) {
    print('Error logging out: $e');
  }
}
Future<List<Map<String, dynamic>>> _fetchPackages() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('packages').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  } catch (e) {
    throw Exception('Failed to load packages: $e');
  }
}



class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchTerms;

  CustomSearchDelegate({required this.searchTerms});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFE1C767), // Custom background color of the search bar
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.black, // Search text color
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black), // Hint text color
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black, // Cursor color in the search box
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.green, // Change the text color of the result
              fontWeight: FontWeight.bold,
            ),
          ),
          tileColor: Colors.white, // Change the background color of the result item
          onTap: () {
            close(context, result); // Select the search result and close search
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.black, // Change the text color of the suggestion
            ),
          ),
          tileColor: Color(0xFFEEE2B3), // Change the background color of the suggestion item
          onTap: () {
            close(context, result); // Close search and return the selected result
          },
        );
      },
    );
  }
}

Future<List<String>> _fetchPackageNames() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('packages').get();
    return snapshot.docs.map((doc) => doc['name'].toString()).toList();
  } catch (e) {
    throw Exception('Failed to load package names: $e');
  }
}

