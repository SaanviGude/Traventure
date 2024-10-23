import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Details'),
        backgroundColor: Color(0xFF5E8953),
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
                String rating = data['rating'] ?? 'No rating';
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
                    Text('Rating: $rating', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Description: $description', style: TextStyle(fontSize: 18)),

                    // Add some space before the button
                    SizedBox(height: 20),

                    // "Edit" button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPackagePage(
                                userId: widget.userId,
                                packageId: widget.packageId,
                                /*imageUrl: imageUrl,
                                title: title,
                                price: price,
                                days: days,
                                rating: rating,
                                description: description,*/
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
