/*import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';
class PackageDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

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
            // Display the image using Image.memory or Image.network
            image.isNotEmpty
            ? Image.memory(
            base64Decode(image), // Decode the base64 image
            fit: BoxFit.cover,
            height: 200, // Set height as needed
            width: double.infinity, // Make it full width
          )
              : Container(), // Empty container if no image

       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Price: $price', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Duration: $days', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Rating: $rating', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('description: $description', style: TextStyle(fontSize: 18)),
            // Add more details or images here as needed
          ],
        ),
      ),
],
    )
    ),
    ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding

class PackageDetailPage extends StatelessWidget {
  final String? image;
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    // Check if the image string has a Base64 prefix and remove it if present
   /* String base64String = image.startsWith('data:image')
        ? image.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '')
        : image; // Strip the prefix if it exists
*/
    Uint8List? imageData;
    if (image != null && image!.startsWith('data:image')) {
      try {
        String base64String = image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
      } catch (e) {
        imageData = null;  // If decoding fails, set imageData to null
      }
    }
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
              // Display the image using Image.memory or Image.network
              imageData != null
                  ? Image.memory(
                imageData, // Display the decoded image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: $days', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: $rating', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: $description', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
*/

//this is little proper
/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding

class PackageDetailPage extends StatelessWidget {
  final String? image;  // Can be a Base64 string or asset name
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData;
    bool isBase64Image = false;

    // Check if the image is a Base64 string and decode it
    if (image != null && image!.startsWith('data:image')) {
      try {
        String base64String = image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
        isBase64Image = true; // Flag that it's a Base64 image
      } catch (e) {
        imageData = null;  // If decoding fails, set imageData to null
        print('Error decoding Base64 image: $e');
      }
    }

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
              // Display image: Base64 image, asset image, or a placeholder
              image != null
                  ? (isBase64Image
                  ? Image.memory(
                imageData!, // Display the decoded image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Image.asset(
                image!,  // If not Base64, assume it's an asset image
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              ))
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: $days', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: $rating', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: $description', style: TextStyle(fontSize: 18)),
            ],
          ),

        ),
      ),

    );
  }
}
*/
//this is not
/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding
import 'dart:io';        // To handle file paths

class PackageDetailPage extends StatelessWidget {
  final String? image;  // Can be a Base64 string, asset name, or file path
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData;
    bool isBase64Image = false;
    bool isFileImage = false;

    // Check if the image is a Base64 string and decode it
    if (image != null && image!.startsWith('data:image')) {
      try {
        String base64String = image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
        isBase64Image = true; // Flag that it's a Base64 image
      } catch (e) {
        imageData = null;  // If decoding fails, set imageData to null
        print('Error decoding Base64 image: $e');
      }
    }
    // Check if the image is a file path (local file)
    else if (image != null && File(image!).existsSync()) {
      isFileImage = true;
    }

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
              // Display image: Base64 image, file image, asset image, or a placeholder
              image != null
                  ? (isBase64Image
                  ? Image.memory(
                imageData!, // Display the decoded image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : isFileImage
                  ? Image.file(
                File(image!),  // Display the image from a file path
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              )
                  : Image.asset(
                image!,  // If not Base64 or file, assume it's an asset image
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              ))
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: $days', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: $rating', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: $description', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding
import 'dart:io';        // To handle file paths
import 'package:image_picker/image_picker.dart';  // For picking images

class PackageDetailPage extends StatefulWidget {
  final String? image;  // Can be a Base64 string, asset name, or file path
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  _PackageDetailPageState createState() => _PackageDetailPageState();
}

class _PackageDetailPageState extends State<PackageDetailPage> {
  Uint8List? imageData;
  bool isBase64Image = false;
  bool isFileImage = false;
  File? selectedImageFile;  // To store the selected image file

  @override
  void initState() {
    super.initState();
    _processImage();
  }

  // Process the incoming image data (Base64, file path, or asset)
  void _processImage() {
    if (widget.image != null && widget.image!.startsWith('data:image')) {
      // Handle Base64 image
      try {
        String base64String = widget.image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
        isBase64Image = true;
      } catch (e) {
        print('Error decoding Base64 image: $e');
        imageData = null;
      }
    } else if (widget.image != null && File(widget.image!).existsSync()) {
      // Handle file path
      selectedImageFile = File(widget.image!);
      isFileImage = true;
    }
  }

  // Method to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImageFile = File(pickedFile.path);
        isFileImage = true;
        isBase64Image = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Button to pick an image from the gallery
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 16.0),

              // Display image: Base64 image, file image, asset image, or a placeholder
              selectedImageFile != null
                  ? Image.file(
                selectedImageFile!,
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : (widget.image != null
                  ? (isBase64Image
                  ? Image.memory(
                imageData!, // Display the decoded Base64 image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Image.asset(
                widget.image!,  // Assume it's an asset image
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              ))
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: ${widget.price}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: ${widget.days}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: ${widget.rating}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: ${widget.description}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding
import 'book.dart';
class PackageDetailPage extends StatelessWidget {
  final String? image;  // Can be a Base64 string or asset name
  final String title;
  final int price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData;
    bool isBase64Image = false;

    // Check if the image is a Base64 string and decode it
    if (image != null && image!.startsWith('data:image')) {
      try {
        String base64String = image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
        isBase64Image = true; // Flag that it's a Base64 image
      } catch (e) {
        imageData = null;  // If decoding fails, set imageData to null
        print('Error decoding Base64 image: $e');
      }
    }

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
              // Display image: Base64 image, asset image, or a placeholder
              image != null
                  ? (isBase64Image
                  ? Image.memory(
                imageData!, // Display the decoded image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Image.asset(
                image!,  // If not Base64, assume it's an asset image
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              ))
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: $days', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: $rating', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: $description', style: TextStyle(fontSize: 18)),

              // Add some space before the button
              SizedBox(height: 20),

              // "Book Now" button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                   
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BookingPage(packageName: title)));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Color(0xFF5E8953), // Same color as AppBar
                  ),
                  child: Text(
                    'Book Now',
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
//1st code
*/

//2nd code
/*import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';
class PackageDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

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
            // Display the image using Image.memory or Image.network
            image.isNotEmpty
            ? Image.memory(
            base64Decode(image), // Decode the base64 image
            fit: BoxFit.cover,
            height: 200, // Set height as needed
            width: double.infinity, // Make it full width
          )
              : Container(), // Empty container if no image

       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Price: $price', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Duration: $days', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Rating: $rating', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('description: $description', style: TextStyle(fontSize: 18)),
            // Add more details or images here as needed
          ],
        ),
      ),
],
    )
    ),
    ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding

class PackageDetailPage extends StatelessWidget {
  final String? image;
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    // Check if the image string has a Base64 prefix and remove it if present
   /* String base64String = image.startsWith('data:image')
        ? image.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '')
        : image; // Strip the prefix if it exists
*/
    Uint8List? imageData;
    if (image != null && image!.startsWith('data:image')) {
      try {
        String base64String = image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
      } catch (e) {
        imageData = null;  // If decoding fails, set imageData to null
      }
    }
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
              // Display the image using Image.memory or Image.network
              imageData != null
                  ? Image.memory(
                imageData, // Display the decoded image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: $days', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: $rating', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: $description', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
*/

//this is little proper
/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding

class PackageDetailPage extends StatelessWidget {
  final String? image;  // Can be a Base64 string or asset name
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData;
    bool isBase64Image = false;

    // Check if the image is a Base64 string and decode it
    if (image != null && image!.startsWith('data:image')) {
      try {
        String base64String = image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
        isBase64Image = true; // Flag that it's a Base64 image
      } catch (e) {
        imageData = null;  // If decoding fails, set imageData to null
        print('Error decoding Base64 image: $e');
      }
    }

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
              // Display image: Base64 image, asset image, or a placeholder
              image != null
                  ? (isBase64Image
                  ? Image.memory(
                imageData!, // Display the decoded image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Image.asset(
                image!,  // If not Base64, assume it's an asset image
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              ))
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: $days', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: $rating', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: $description', style: TextStyle(fontSize: 18)),
            ],
          ),

        ),
      ),

    );
  }
}
*/
//this is not
/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding
import 'dart:io';        // To handle file paths

class PackageDetailPage extends StatelessWidget {
  final String? image;  // Can be a Base64 string, asset name, or file path
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData;
    bool isBase64Image = false;
    bool isFileImage = false;

    // Check if the image is a Base64 string and decode it
    if (image != null && image!.startsWith('data:image')) {
      try {
        String base64String = image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
        isBase64Image = true; // Flag that it's a Base64 image
      } catch (e) {
        imageData = null;  // If decoding fails, set imageData to null
        print('Error decoding Base64 image: $e');
      }
    }
    // Check if the image is a file path (local file)
    else if (image != null && File(image!).existsSync()) {
      isFileImage = true;
    }

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
              // Display image: Base64 image, file image, asset image, or a placeholder
              image != null
                  ? (isBase64Image
                  ? Image.memory(
                imageData!, // Display the decoded image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : isFileImage
                  ? Image.file(
                File(image!),  // Display the image from a file path
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              )
                  : Image.asset(
                image!,  // If not Base64 or file, assume it's an asset image
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              ))
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: $days', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: $rating', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: $description', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';   // For Base64 encoding and decoding
import 'dart:io';        // To handle file paths
import 'package:image_picker/image_picker.dart';  // For picking images

class PackageDetailPage extends StatefulWidget {
  final String? image;  // Can be a Base64 string, asset name, or file path
  final String title;
  final String price;
  final String days;
  final String rating;
  final String description;

  PackageDetailPage({
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description
  });

  @override
  _PackageDetailPageState createState() => _PackageDetailPageState();
}

class _PackageDetailPageState extends State<PackageDetailPage> {
  Uint8List? imageData;
  bool isBase64Image = false;
  bool isFileImage = false;
  File? selectedImageFile;  // To store the selected image file

  @override
  void initState() {
    super.initState();
    _processImage();
  }

  // Process the incoming image data (Base64, file path, or asset)
  void _processImage() {
    if (widget.image != null && widget.image!.startsWith('data:image')) {
      // Handle Base64 image
      try {
        String base64String = widget.image!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        imageData = base64Decode(base64String);
        isBase64Image = true;
      } catch (e) {
        print('Error decoding Base64 image: $e');
        imageData = null;
      }
    } else if (widget.image != null && File(widget.image!).existsSync()) {
      // Handle file path
      selectedImageFile = File(widget.image!);
      isFileImage = true;
    }
  }

  // Method to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImageFile = File(pickedFile.path);
        isFileImage = true;
        isBase64Image = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Button to pick an image from the gallery
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 16.0),

              // Display image: Base64 image, file image, asset image, or a placeholder
              selectedImageFile != null
                  ? Image.file(
                selectedImageFile!,
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : (widget.image != null
                  ? (isBase64Image
                  ? Image.memory(
                imageData!, // Display the decoded Base64 image data
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Image.asset(
                widget.image!,  // Assume it's an asset image
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity,
              ))
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: ${widget.price}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Duration: ${widget.days}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Rating: ${widget.rating}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Description: ${widget.description}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}*/
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'book.dart';

class PackageDetailPage extends StatelessWidget {
  final String? userId;
  final String? imageUrl;  // URL of the image stored in Firebase Storage
  final String title;
  final double price;
  final String days;
  final String location_url;
  final String description;

  PackageDetailPage({
    required this.userId,
    required this.imageUrl,  // Use imageUrl instead of image
    required this.title,
    required this.price,
    required this.days,
    required this.location_url,
    required this.description
  });

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
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image from Firebase Storage or show a placeholder
              imageUrl != null
                  ? Image.network(
                imageUrl!, // Load the image from the URL
                fit: BoxFit.cover,
                height: 200, // Set height as needed
                width: double.infinity, // Make it full width
              )
                  : Container(
                height: 200, // Placeholder height
                color: Colors.grey, // Placeholder background color
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space between elements

              // Display the package details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Price: $price', style: TextStyle(fontSize: 18)),
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

              // Add some space before the button
              SizedBox(height: 20),

              // "Book Now" button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(
                          packageName: title,
                          userId: FirebaseAuth.instance.currentUser?.uid,
                          price: price,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Color(0xFF5E8953), // Same color as AppBar
                  ),
                  child: Text(
                    'Book Now',
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
