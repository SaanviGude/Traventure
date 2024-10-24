import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter_basics/extra/full%20test/guideprofile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'gprofile.dart';

class EditGuideProfile extends StatefulWidget {
  final String? userId;

  EditGuideProfile({required this.userId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditGuideProfile> {
  late Future<Map<String, dynamic>?> userData;
  final _formKey = GlobalKey<FormState>();

  // Controllers for the editable fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  File? _selectedImage;
  String? _imageUrl; // Store the image URL

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      userData = fetchUserData(widget.userId!);
    } else {
      userData = Future.value(null);
    }
  }

  // Fetch user data from Firestore
  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('guides')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        // Initialize controllers with user data
        nameController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        aadhaarController.text = data['aadhaar'] ?? '';
        addressController.text = data['address'] ?? '';
        emailController.text = data['email'] ?? '';
        _imageUrl = data['imageUrl']; // Set the image URL
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // Save user data back to Firestore
  Future<void> saveUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        Map<String, dynamic> updatedData = {
          'name': nameController.text,
          'phone': phoneController.text,
          'aadhaar': aadhaarController.text,
          'address': addressController.text,
          'email': emailController.text,
        };

        if (_selectedImage != null) {
          String imageUrl = await _uploadImageToStorage(widget.userId!);
          updatedData['imageUrl'] = imageUrl;
        }

        await FirebaseFirestore.instance
            .collection('guides')
            .doc(widget.userId)
            .update(updatedData);

        // Show confirmation dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Your details have been saved.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        print("Error saving user data: $e");
      }
    }
  }

  // Image picker to select the image from gallery or camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  // Upload image to Firebase Storage and get the download URL
  Future<String> _uploadImageToStorage(String userId) async {
    Reference ref = FirebaseStorage.instance.ref().child('profile_images/$userId');
    await ref.putFile(_selectedImage!);
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/AppHS.jpeg', // Path to your image
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Color(0xFF315E3C),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFFDCD0A1)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text(
                      'EDIT PROFILE',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 28,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FutureBuilder<Map<String, dynamic>?>(
                          future: userData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error fetching data');
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return Text('No user data found');
                            } else {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: _pickImage,
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: _selectedImage != null
                                              ? FileImage(_selectedImage!)
                                              : _imageUrl != null
                                              ? NetworkImage(_imageUrl!)
                                              : null,
                                          child: _selectedImage == null && _imageUrl == null
                                              ? Icon(Icons.person, size: 50, color: Colors.black)
                                              : null,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'GUIDE-ID: ${widget.userId}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Arial',
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      _buildEditableRow(Icons.person, 'Name', nameController),
                                      _buildEditableRow(Icons.phone, 'Phone', phoneController),
                                      _buildEditableRow(Icons.perm_identity, 'Aadhaar ID', aadhaarController),
                                      _buildEditableRow(Icons.location_on, 'Address', addressController),
                                      _buildEditableRow(Icons.email, 'Email', emailController),
                                      Spacer(),
                                      ElevatedButton(
                                        onPressed: () async {
                                          bool confirm = await _showConfirmationDialog(context);
                                          if (confirm) {
                                            saveUserData();
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) => GProfilePage(userId: widget.userId),
                                              ),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF315F3C),
                                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          'SAVE',
                                          style: TextStyle(
                                            color: Color(0xFFFDEAB2),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableRow(IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.black,
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter $label';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Save'),
          content: Text('Do you want to save the changes?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
