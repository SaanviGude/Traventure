import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore for fetching package details
import 'editpackage.dart';

class PackageGDetailPage extends StatefulWidget {
  final String? userId;
  final String? packageId;

  PackageGDetailPage({
    required this.userId,
    required this.packageId,
  });

  @override
  _PackageGDetailPageState createState() => _PackageGDetailPageState();
}

class _PackageGDetailPageState extends State<PackageGDetailPage> {
  late Future<Map<String, dynamic>?> packageData;

  @override
  void initState() {
    super.initState();
    if (widget.packageId != null) {
      packageData = fetchPackageData(widget.packageId!);
    } else {
      packageData = Future.value(null);
    }
  }

  Future<Map<String, dynamic>?> fetchPackageData(String packageId) async {
    try {
      DocumentSnapshot packageDoc = await FirebaseFirestore.instance
          .collection('packages') // Assuming the collection is 'packages'
          .doc(packageId)
          .get();
      if (packageDoc.exists) {
        return packageDoc.data() as Map<String, dynamic>?;
      } else {
        return null; // No data found
      }
    } catch (e) {
      print("Error fetching package data: $e");
      return null;
    }
  }

  void _launchMaps(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        title:
        Text(
          'PACKAGE DETAILS',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF1F6029),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, dynamic>?>(
            future: packageData, // Fetch the package data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching package data'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No package data found'));
              } else {
                var data = snapshot.data!;

                // Use fetched package data in the UI (title, price, etc.)
                String imageUrl = data['image_url'] ?? ''; // Example: fetching the image URL
                String title = data['name'] ?? 'No title';
                double price = data['price']?.toDouble() ?? 0.0;
                String days = data['days'] ?? 'N/A';
                String location_url = data['location_url'] ?? 'No location';
                String description = data['description'] ?? 'No description';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageUrl.isNotEmpty
                        ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    )
                        : Container(
                      height: 200,
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'No Image Available',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0), // Add space between elements

                    // Display the package details using the fetched data
                    Text(
                      title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Price: \$${price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Duration: $days', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _launchMaps(location_url); // Open the location URL in maps
                      },
                      child: Text(
                        'View on Map',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue, // Make the text blue to signify it's clickable
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Description: $description', style: TextStyle(fontSize: 18)),

                    // Add some space before the buttons
                    SizedBox(height: 20),

                    // Row for the "Edit" and "Delete" buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensure buttons are equidistant
                      children: [
                        // "Edit" button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPackagePage(
                                  userId: widget.userId,
                                  packageId: widget.packageId,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            backgroundColor: Color(0xFF5E8953), // Same color as AppBar
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),

                        // "Delete" button
                        ElevatedButton(
                          onPressed: () async {
                            bool confirmDelete = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text('Are you sure you want to delete this package?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false); // Cancel deletion
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true); // Confirm deletion
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            ) ?? false;

                            if (confirmDelete) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('packages')
                                    .doc(widget.packageId)
                                    .delete(); // Delete the package document

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Package deleted successfully.'),
                                  backgroundColor: Colors.red,
                                ));

                                Navigator.of(context).pop(); // Navigate back after deletion
                              } catch (e) {
                                print("Error deleting package: $e");
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Error deleting package: $e'),
                                ));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            backgroundColor: Colors.red, // Red color for delete button
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

}
