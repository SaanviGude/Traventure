import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_basics/main.dart';
import 'package:flutter_basics/notprofile.dart';
import 'dart:io'; // For handling files
import 'package:image_picker/image_picker.dart'; // For picking images
import 'main.dart';
import 'feed.dart';
import 'history.dart';
import 'package_detail_anonymous.dart';
import 'helpdesk.dart';
import 'package:url_launcher/url_launcher.dart';

class noHomePage extends StatefulWidget {
  final String? selectedSearch;
  final String? userId;
  noHomePage({this.selectedSearch, required this.userId});
  @override
  _noHomePageState createState() => _noHomePageState();
}

class _noHomePageState extends State<noHomePage> {
  List<Map<String, dynamic>> _tripPackages = []; // Store packages here
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAndSetPackages(); // Fetch the packages when the widget is first built
  }

  // Fetch and set packages
  Future<void> _fetchAndSetPackages() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final fetchedPackages = await _fetchPackages();
      setState(() {
        _tripPackages = fetchedPackages; // Set the fetched packages
      });
    } catch (e) {
      // Handle error
      print('Error fetching packages: $e');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
    File? _image;
    final picker = ImagePicker();

    // Function to pick image from gallery
    Future<void> _pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Color(0xFFDCD0A1),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Color(0xFF5E8953),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              List<String> packageNames = await _fetchPackageNames();
              final result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchTerms: packageNames),
              );

              if (result != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => noHomePage(
                      selectedSearch: result,
                      userId: widget.userId,
                    ),
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
                MaterialPageRoute(
                  builder: (context) => NoProfilePage(
                    userId: FirebaseAuth.instance.currentUser?.uid,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.account_circle_sharp, size: 30),
            color: Color(0xFFDCD0A1),
          ),
        ],
        title: Text('User Homepage', overflow: TextOverflow.ellipsis),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFFBF6DF),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // User Profile Section
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/U.png'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'USER',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                FirebaseAuth.instance.currentUser?.uid ??
                                    'Id not available',
                                style: TextStyle(fontSize: 10.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.history, size: 50),
                    title: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoProfilePage(userId:  FirebaseAuth.instance.currentUser?.uid)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback_outlined, size: 50),
                    title: const Text('Feedback',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoProfilePage(userId:  FirebaseAuth.instance.currentUser?.uid)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help_center, size: 50),
                    title: const Text('Help desk',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => helpdesk()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined, size: 50),
                    title: const Text('Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,)),
                    onTap: () {
                      _logout(context); // Call the log-out function
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete_outline, size: 50),
                    title: const Text('Delete account',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,),
                    ),
                    onTap: () {
                      _showDeleteAccountDialog(context);
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
              ? tripPackages.where((package) => package['name']!
              .toLowerCase()
              .contains(widget.selectedSearch!.toLowerCase()))
              .toList()
              : tripPackages;

          return RefreshIndicator(  // Added RefreshIndicator here
            onRefresh: _fetchAndSetPackages, // This will be called when user swipes down
            child: Padding(
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
                    image: trip['image_url'] ?? 'https://via.placeholder.com/150',
                    name: trip['name'] ?? 'Unknown',
                    price: trip['price'] ?? 0.0,
                    days: trip['days'] ?? '0',
                    location_url: trip['location_url'] ?? 'No location',
                    description: trip['description'] ?? 'No description available',
                    packageId: trip['packageId'], // Using the package ID
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// TripCard Widget
class TripCard extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final String days;
  final String location_url;
  final String description;
  final String packageId;

  const TripCard({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.days,
    required this.location_url,
    required this.description,
    required this.packageId,
  }) : super(key: key);

  // Function to launch a URL (Google Maps in this case)
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => noPackageDetailPage(
              userId: FirebaseAuth.instance.currentUser?.uid,
              imageUrl: image,
              title: name,
              price: price,
              days: days,
              location_url: location_url,
              description: description,
              //packageId: packageId, // Pass package ID to detail page
            ),
          ),
        );
      },
      child: Card(
        child: Container(
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
                  image, // Image URL from Firebase Storage
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      'https://via.placeholder.com/150', // Placeholder in case of an error
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
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
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(location_url); // Open location URL in Maps
                          },
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.blue, size: 16),
                              SizedBox(width: 5),
                              Text(
                                'View on Map',
                                style: TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                            ],
                          ),
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
    );
  }
}


void _showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Account"),
        content: Text("Are you sure you want to delete your account? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog without deleting
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _deleteAccount(context); // Perform account deletion
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

void _deleteAccount(BuildContext context) async {
  try {
    // Re-authenticate the user before deletion (Firebase requires this for sensitive operations)
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload(); // Reload to ensure user is up-to-date

      // Delete the user from Firebase Authentication
      await user.delete();

      // Show a snackbar to confirm account deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account deleted successfully"),
          backgroundColor: Colors.blueGrey,
        ),
      );

      // After deletion, you might want to log the user out and navigate to a login screen
      await FirebaseAuth.instance.signOut();

      // Navigate to login or home page after deletion
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); // Replace '/login' with your actual login route
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No user is signed in"),
          backgroundColor: Colors.blueGrey,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed to delete account: $e"),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}

Future<void> _reauthenticateUser() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      // Prompt the user to re-enter their credentials
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: 'user_password', // You'll need to collect the password from the user
      );

      // Re-authenticate the user
      await user.reauthenticateWithCredential(credential);
    } catch (e) {
      throw FirebaseAuthException(code: 'Re-authentication failed: $e');
    }
  }
}


// Function to fetch package names
Future<List<String>> _fetchPackageNames() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('packages').get();
    return snapshot.docs
        .map((doc) => (doc.data() as Map<String, dynamic>)['name'] as String)
        .toList();
  } catch (e) {
    throw Exception('Failed to load package names: $e');
  }
}

// Function to fetch package data from Firestore
Future<List<Map<String, dynamic>>> _fetchPackages() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('packages').get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        'name': data['name'] ?? 'Unknown',
        'price': data['price'] ?? 'N/A',
        'days': data['days'] ?? '0',
        'location_url': data['location_url'] ?? 'No location',
        'description': data['description'] ?? 'No description available',
        'image_url': data['image_url'] ?? 'https://via.placeholder.com/150', // Use image URL from Firestore
        'packageId': data['packageId'] ?? doc.id, // Ensure the package ID is available
      };
    }).toList();
  } catch (e) {
    throw Exception('Failed to load packages: $e');
  }
}

// Function to upload image to Firebase Storage
Future<String> _uploadImageToStorage(File imageFile) async {
  try {
    // Define a unique file name for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to Firebase Storage
    Reference ref = FirebaseStorage.instance.ref().child('package_images').child(fileName);

    // Upload the image file
    UploadTask uploadTask = ref.putFile(imageFile);

    // Wait for the upload to complete
    TaskSnapshot snapshot = await uploadTask;

    // Get the download URL of the uploaded image
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    throw Exception('Error uploading image: $e');
  }
}

// Function to add package with image and unique ID
Future<void> _addPackageWithImage({
  required String name,
  required double price,
  required String days,
  required String location_url,
  required String description,
  required File imageFile,
}) async {
  try {
    // Upload image to Firebase Storage
    String imageUrl = await _uploadImageToStorage(imageFile);

    // Generate a new document with an ID
    DocumentReference docRef = FirebaseFirestore.instance.collection('packages').doc();

    // Create a new package with the image URL and a unique packageId
    await docRef.set({
      'name': name,
      'price': price,
      'days': days,
      'location_url': location_url,
      'description': description,
      'image': imageUrl, // Store the image URL
      'packageId': docRef.id, // Store the generated document ID as the packageId
    });

    print('Package added with ID: ${docRef.id}');
  } catch (e) {
    print('Error adding package: $e');
  }
}

// Function to logout
Future<void> _logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => MyApp()),
        (route) => false,
  );
}

// Custom Search Delegate for searching packages
class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchTerms;

  CustomSearchDelegate({required this.searchTerms});

  @override
  List<Widget>? buildActions(BuildContext context) {
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
  Widget? buildLeading(BuildContext context) {
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
        return ListTile(
          title: Text(matchQuery[index]),
          onTap: () {
            close(context, matchQuery[index]);
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
        return ListTile(
          title: Text(matchQuery[index]),
          onTap: () {
            close(context, matchQuery[index]);
          },
        );
      },
    );
  }
}