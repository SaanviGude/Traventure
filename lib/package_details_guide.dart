import 'package:flutter/material.dart';
import 'editpackage.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage

class PackageGDetailPage extends StatelessWidget {
  final String? userId;
  final String? packageId; // Add the packageId here
  final String? imageUrl;
  final String title;
  final double price; // Ensure this is a double
  final String days;
  final String rating;
  final String description;

  PackageGDetailPage({
    required this.userId,
    required this.packageId, // Add packageId to constructor
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description,
  });

  Future<String> _getImageUrl() async {
    if (imageUrl != null) {
      return imageUrl!; // Use the provided image URL if it exists
    } else if (packageId != null) {
      // Construct the image URL dynamically using packageId
      try {
        final ref = FirebaseStorage.instance.ref().child('packages/$packageId.jpg'); // Assuming the image is stored with the packageId
        String url = await ref.getDownloadURL();
        return url;
      } catch (e) {
        print('Error fetching image: $e');
        return ''; // Return an empty string if image fetching fails
      }
    } else {
      return ''; // Return an empty string if neither imageUrl nor packageId is available
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                future: _getImageUrl(), // Fetch the image URL
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 200,
                      color: Colors.grey,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError || snapshot.data == '') {
                    return Container(
                      height: 200,
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'No Image Available',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    );
                  }
                },
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Convert price to double and format
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
                          userId: userId,
                          imageUrl: imageUrl,
                          title: title,
                          price: price,
                          days: days,
                          rating: rating,
                          description: description,
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
          ),
        ),
      ),
    );
  }
}
