import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_basics/package_details_guide.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';

class EditPackagePage extends StatefulWidget {
  final String? packageId;
  final String? userId;// This userId should be the document ID of the package

  EditPackagePage({
    required this.packageId,
    required this.userId
  });

  @override
  _EditPackagePageState createState() => _EditPackagePageState();
}

class _EditPackagePageState extends State<EditPackagePage> {
  late Future<Map<String, dynamic>?> packageData;
  final _formKey = GlobalKey<FormState>();

  // Controllers for the editable fields
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController locationUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Uint8List? _imageBytes;
  String? _imageUrl;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.packageId != null) {
      // Load the existing package details for editing
      packageData = fetchPackageData(widget.packageId!);
    } else {
      packageData = Future.value(null);
    }
  }

  // Fetch package data from Firestore
  Future<Map<String, dynamic>?> fetchPackageData(String userId) async {
    try {
      DocumentSnapshot packageDoc = await FirebaseFirestore.instance
          .collection('packages') // Ensure the correct Firestore collection is used
          .doc(userId)
          .get();
      if (packageDoc.exists) {
        var data = packageDoc.data() as Map<String, dynamic>;
        // Populate controllers with the existing package data
        titleController.text = data['name'] ?? '';
        priceController.text = data['price'].toString();
        daysController.text = data['days'] ?? '';
        locationUrlController.text = data['location_url'] ?? '';
        descriptionController.text = data['description'] ?? '';
        _imageUrl = data['image_url'];  // Load the existing image URL
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching package data: $e");
      return null;
    }
  }

  // Save edited package data back to Firestore
  Future<void> savePackageData() async {
    if (_formKey.currentState!.validate()) {
      try {
        double? price = double.tryParse(priceController.text);
        if (price == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a valid price.')),
          );
          return;
        }

        // Prepare the updated data to be saved
        Map<String, dynamic> updatedData = {
          'name': titleController.text,
          'price': price,
          'days': daysController.text,
          'location_url': locationUrlController.text,
          'description': descriptionController.text,
        };

        // If a new image was selected, upload it and update the image URL
        if (_selectedImage != null) {
          String imageUrl = await _uploadImageToStorage(widget.packageId!);
          updatedData['image_url'] = imageUrl;  // Update the image URL
        }

        // Update the existing package document in Firestore (don't create a new one)
        await FirebaseFirestore.instance
            .collection('packages') // Ensure you're using the right collection
            .doc(widget.packageId)     // The same document ID (existing package)
            .update(updatedData);   // This updates the existing data

        // Show confirmation dialog
        _showConfirmationDialog();
      } catch (e) {
        print("Error saving package data: $e");
      }
    }
  }

  // Image picker to select an image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Upload the selected image to Firebase Storage and get the download URL
  Future<String> _uploadImageToStorage(String userId) async {
    Reference ref = FirebaseStorage.instance.ref().child('packages/$userId');
    await ref.putFile(_selectedImage!);
    return await ref.getDownloadURL();
  }

  // Show confirmation dialog after successfully saving data
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Package details have been saved successfully!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageGDetailPage(userId: widget.userId, packageId: widget.packageId), // Replace with the correct page
                  ),
                );

              },
            ),
          ],
        );
      },
    );
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
          'EDIT PACKAGE',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: packageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading package data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No package data found'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDEDEA),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _selectedImage != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                              : (_imageUrl != null
                              ? Image.network(_imageUrl!)
                              : Center(child: Text('Tap to select an image'))),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(titleController, 'Package Title'),
                      SizedBox(height: 10),
                      _buildTextField(priceController, 'Price', isNumeric: true),
                      SizedBox(height: 10),
                      _buildTextField(daysController, 'Duration (Days)'),
                      SizedBox(height: 10),
                      _buildTextField(locationUrlController, 'Location'),
                      SizedBox(height: 10),
                      _buildTextField(descriptionController, 'Description'),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: savePackageData,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            backgroundColor: Color(0xFF5E8953),
                          ),
                          child: Text(
                            'Save',
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
        },
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
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
