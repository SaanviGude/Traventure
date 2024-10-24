/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';
class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes; // To store the selected image bytes
  final ImagePicker _picker = ImagePicker();
/*
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // For web, read the file as a blob and create a URL
      final reader = html.FileReader();
      final file = html.File([pickedFile.readAsBytes()],pickedFile.path);
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          // Convert the result to bytes
          _imageBytes = reader.result as Uint8List;
        });
      });
    }
    else {
      // Handle the case when no file was picked
      print("No image selected.");
    }
  }*//*

  Future<void> handleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Your mobile-specific file handling code
    }
  }
  Future<void> _addPackage() async {
    await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': _priceController.text,
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
      // If you need to store the image, convert it to base64 and save it.
      'image': _imageBytes != null ? 'data:image/png;base64,' + base64Encode(_imageBytes!) : null,
    });
    Navigator.pop(context); // Navigate back after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Package'),
        backgroundColor: Color(0xFF4D8C53),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            _buildTextField(_nameController, 'Package Name'),
            SizedBox(height: 24),
            _buildTextField(_priceController, 'Price'),
            SizedBox(height: 24),
            _buildTextField(_daysController, 'Duration (Days)'),
            SizedBox(height: 24),
            _buildTextField(_ratingController, 'Rating'),
            SizedBox(height: 24),
            _buildTextField(_descriptionController, 'Description'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: handleFile, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(child: Text('Tap to select an image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
1st code
*//*


//2nd code
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';
class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes; // To store the selected image bytes
  final ImagePicker _picker = ImagePicker();
/*
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // For web, read the file as a blob and create a URL
      final reader = html.FileReader();
      final file = html.File([pickedFile.readAsBytes()],pickedFile.path);
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          // Convert the result to bytes
          _imageBytes = reader.result as Uint8List;
        });
      });
    }
    else {
      // Handle the case when no file was picked
      print("No image selected.");
    }
  }*//*

  Future<void> handleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Your mobile-specific file handling code
    }
  }
  Future<void> _addPackage() async {
    await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': _priceController.text,
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
      // If you need to store the image, convert it to base64 and save it.
      'image': _imageBytes != null ? 'data:image/png;base64,' + base64Encode(_imageBytes!) : null,
    });
    Navigator.pop(context); // Navigate back after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Package'),
        backgroundColor: Color(0xFF4D8C53),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            _buildTextField(_nameController, 'Package Name'),
            SizedBox(height: 24),
            _buildTextField(_priceController, 'Price'),
            SizedBox(height: 24),
            _buildTextField(_daysController, 'Duration (Days)'),
            SizedBox(height: 24),
            _buildTextField(_ratingController, 'Rating'),
            SizedBox(height: 24),
            _buildTextField(_descriptionController, 'Description'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: handleFile, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(child: Text('Tap to select an image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
1st code
*//*


//2nd code


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes; // To store the selected image bytes
  final ImagePicker _picker = ImagePicker(); // For picking the image

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Read image bytes asynchronously
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes; // Store the bytes in _imageBytes
      });
    }
  }

  Future<String?> _uploadImageToStorage() async {
    if (_imageBytes == null) return null;

    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageRef = FirebaseStorage.instance.ref().child('packages/$fileName');
      UploadTask uploadTask = storageRef.putData(_imageBytes!);

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      return null;
    }
  }

  Future<void> _addPackage() async {
    double? price = double.tryParse(_priceController.text);
   */
/* if (_ratingController > 5){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('enter valid rating')),
      );
    }*//*

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid price.')),
      );
      return;
    }

    // Check if an image is selected
    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image.')),
      );
      return;
    }

    // Upload the image to Firebase Storage and get the download URL
    String? imageUrl = await _uploadImageToStorage();

    // If the imageUrl is null, show an error message
    if (imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload the image.')),
      );
      return;
    }

    // Add package details to Firestore
    DocumentReference docRef = await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': price.toDouble(),
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
      'image_url': imageUrl, // Ensure non-null image URL
    });

    // Pass the package ID to the success dialog or next page
    String packageId = docRef.id;

    _showSuccessDialog(packageId); // Pass the ID to the success dialog
  }

*/
/*
  Future<void> _addPackage() async {
    double? price = double.tryParse(_priceController.text);

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid price.')),
      );
      return;
    }

    // Upload the image to Firebase Storage and get the download URL
    String? imageUrl = await _uploadImageToStorage();

    // Add package details to Firestore and get the document reference
    DocumentReference docRef = await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': price,
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
      'image_url': imageUrl, // Store the image URL
    });

    // Pass the package ID to the success dialog or next page
    String packageId = docRef.id;

    _showSuccessDialog(packageId); // Pass the ID to the success dialog
  }
*//*

  void _showSuccessDialog(String packageId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Package details have been saved successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pop(context, packageId); // Navigate back with packageId
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Package'),
        backgroundColor: Color(0xFF4D8C53),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            _buildTextField(_nameController, 'Package Name'),
            SizedBox(height: 24),
            _buildTextField(_priceController, 'Price', isNumeric: true),
            SizedBox(height: 24),
            _buildTextField(_daysController, 'Duration (Days)'),
            SizedBox(height: 24),
            _buildTextField(_ratingController, 'Rating'),
            SizedBox(height: 24),
            _buildTextField(_descriptionController, 'Description'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(child: Text('Tap to select an image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}


*/




/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';
class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes; // To store the selected image bytes
  final ImagePicker _picker = ImagePicker();
/*
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // For web, read the file as a blob and create a URL
      final reader = html.FileReader();
      final file = html.File([pickedFile.readAsBytes()],pickedFile.path);
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          // Convert the result to bytes
          _imageBytes = reader.result as Uint8List;
        });
      });
    }
    else {
      // Handle the case when no file was picked
      print("No image selected.");
    }
  }*/
  Future<void> handleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Your mobile-specific file handling code
    }
  }
  Future<void> _addPackage() async {
    await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': _priceController.text,
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
      // If you need to store the image, convert it to base64 and save it.
      'image': _imageBytes != null ? 'data:image/png;base64,' + base64Encode(_imageBytes!) : null,
    });
    Navigator.pop(context); // Navigate back after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Package'),
        backgroundColor: Color(0xFF4D8C53),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            _buildTextField(_nameController, 'Package Name'),
            SizedBox(height: 24),
            _buildTextField(_priceController, 'Price'),
            SizedBox(height: 24),
            _buildTextField(_daysController, 'Duration (Days)'),
            SizedBox(height: 24),
            _buildTextField(_ratingController, 'Rating'),
            SizedBox(height: 24),
            _buildTextField(_descriptionController, 'Description'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: handleFile, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(child: Text('Tap to select an image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
1st code
*/

//2nd code
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // To handle image data as bytes
import 'dart:convert';
class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes; // To store the selected image bytes
  final ImagePicker _picker = ImagePicker();
/*
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // For web, read the file as a blob and create a URL
      final reader = html.FileReader();
      final file = html.File([pickedFile.readAsBytes()],pickedFile.path);
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          // Convert the result to bytes
          _imageBytes = reader.result as Uint8List;
        });
      });
    }
    else {
      // Handle the case when no file was picked
      print("No image selected.");
    }
  }*/
  Future<void> handleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Your mobile-specific file handling code
    }
  }
  Future<void> _addPackage() async {
    await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': _priceController.text,
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
      // If you need to store the image, convert it to base64 and save it.
      'image': _imageBytes != null ? 'data:image/png;base64,' + base64Encode(_imageBytes!) : null,
    });
    Navigator.pop(context); // Navigate back after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Package'),
        backgroundColor: Color(0xFF4D8C53),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            _buildTextField(_nameController, 'Package Name'),
            SizedBox(height: 24),
            _buildTextField(_priceController, 'Price'),
            SizedBox(height: 24),
            _buildTextField(_daysController, 'Duration (Days)'),
            SizedBox(height: 24),
            _buildTextField(_ratingController, 'Rating'),
            SizedBox(height: 24),
            _buildTextField(_descriptionController, 'Description'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: handleFile, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(child: Text('Tap to select an image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
1st code
*/

//2nd code
/*

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _locationController = TextEditingController(); // Changed from _locationUrlController
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes; // To store the selected image bytes
  final ImagePicker _picker = ImagePicker(); // For picking the image

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Read image bytes asynchronously
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes; // Store the bytes in _imageBytes
      });
    }
  }

  Future<String?> _uploadImageToStorage() async {
    if (_imageBytes == null) return null;

    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageRef = FirebaseStorage.instance.ref().child('packages/$fileName');
      UploadTask uploadTask = storageRef.putData(_imageBytes!);

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      return null;
    }
  }

  Future<void> _addPackage() async {
    double? price = double.tryParse(_priceController.text);

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid price.')),
      );
      return;
    }

    // Upload the image to Firebase Storage and get the download URL
    String? imageUrl = await _uploadImageToStorage();

    // Add package details to Firestore and get the document reference
    DocumentReference docRef = await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': price,
      'days': _daysController.text,
      'location': _locationController.text, // Changed from _locationUrlController to _locationController
      'description': _descriptionController.text,
      'image_url': imageUrl, // Store the image URL
    });

    // Pass the package ID to the success dialog or next page
    String packageId = docRef.id;

    _showSuccessDialog(packageId); // Pass the ID to the success dialog
  }

  void _showSuccessDialog(String packageId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Package details have been saved successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pop(context, packageId);
              Navigator.of(context); // Navigate back with packageId
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title:
        Text(
          'ADD PACKAGE',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF4D8C53),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            _buildTextField(_nameController, 'Package Name'),
            SizedBox(height: 24),
            _buildTextField(_priceController, 'Price', isNumeric: true),
            SizedBox(height: 24),
            _buildTextField(_daysController, 'Duration (Days)'),
            SizedBox(height: 24),
            _buildTextField(_locationController, 'Location'), // Updated to use _locationController
            SizedBox(height: 24),
            _buildTextField(_descriptionController, 'Description'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(child: Text('Tap to select an image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}


*/
*/*/


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'homepage.dart';
/*


class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();



}


class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _locationUrlController = TextEditingController(); // For location URL
  final TextEditingController _descriptionController = TextEditingController();
 // final TextEditingController _guideIdController = TextEditingController(); // New controller for guide ID
  final String Guideid;

  _AddPackagePageState({ required this.Guideid});

*/

class AddPackagePage extends StatefulWidget {
  final String? guideId; // Guide ID passed from GuideHome

  // Constructor that takes the guideId as a parameter
  AddPackagePage({required this.guideId});

  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _locationUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes; // To store the selected image bytes
  final ImagePicker _picker = ImagePicker(); // For picking the image

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Read image bytes asynchronously
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes; // Store the bytes in _imageBytes
      });
    }
  }

  Future<String?> _uploadImageToStorage() async {
    if (_imageBytes == null) return null;

    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageRef = FirebaseStorage.instance.ref().child('packages/$fileName');
      UploadTask uploadTask = storageRef.putData(_imageBytes!);

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      return null;
    }
  }

  Future<void> _addPackage() async {
    double? price = double.tryParse(_priceController.text);

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid price.')),
      );
      return;
    }

    // Upload the image to Firebase Storage and get the download URL
    String? imageUrl = await _uploadImageToStorage();

    // Add package details to Firestore and get the document reference
    DocumentReference docRef = await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': price,
      'days': _daysController.text,
      'location_url': _locationUrlController.text, // Store the location URL
      'description': _descriptionController.text,
      'image_url': imageUrl, // Store the image URL
      'guideId': widget.guideId,
    });

    // Pass the package ID to the success dialog or next page
    String packageId = docRef.id;

    _showSuccessDialog(packageId); // Pass the ID to the success dialog
  }

  void _showSuccessDialog(String packageId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Package details have been saved successfully!'),
        actions: [
          TextButton(
            onPressed: () {
            /*  Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(packageId);*/
              // Navigate back with packageId
             /* Navigator.of(context).popUntil((route) => route.isFirst);*/
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage(userId: FirebaseAuth.instance.currentUser?.uid,)),
              (route) => false);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Package'),
        backgroundColor: Color(0xFF4D8C53),
      ),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            SizedBox(height: 24),
            _buildTextField(_nameController, 'Package Name'),
            SizedBox(height: 24),
            _buildTextField(_priceController, 'Price', isNumeric: true),
            SizedBox(height: 24),
            _buildTextField(_daysController, 'Duration (Days)'),
            SizedBox(height: 24),
            _buildTextField(_locationUrlController, 'Location URL'), // New location URL field
            SizedBox(height: 24),

            _buildTextField(_descriptionController, 'Description'),

            SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(child: Text('Tap to select an image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}



