import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image picker
import 'main.dart';
import 'guidehome.dart';

class GuideProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<GuideProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _aadhaarController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isUser = true;

  File? _profileImage; // Store picked image
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File imageFile, String userId) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('guide_profile_images')
          .child('$userId.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isUser = false;
                          });
                        },
                        child: Text('GUIDE',
                            style: TextStyle(color: Color(0xFFE4D59F), fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isUser ? Color(0xFF235537) : Color(0xFF4D8C53),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _pickImage, // Image picker logic
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Add Image", style: TextStyle(fontSize: 16, color: Colors.black)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF235537).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                _buildTextField("NAME", _nameController),
                                _buildTextField("PHONE NO:", _phoneController),
                                _buildTextField("AADHAR NO:", _aadhaarController),
                                _buildTextField("ADDRESS:", _addressController, maxLines: 3),
                                _buildTextField("EMAIL:", _emailController),
                                _buildTextField("PASSWORD:", _passwordController, isPassword: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('BACK',
                            style: TextStyle(color: Color(0xFF235537), fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFE4D59F),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Email and password cannot be empty'),
                            ));
                            return;
                          }

                          try {
                            // Firebase Authentication
                            UserCredential userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(email: email, password: password);

                            // Upload profile image if selected
                            String? imageUrl;
                            if (_profileImage != null) {
                              imageUrl = await _uploadImage(
                                  _profileImage!, userCredential.user?.uid ?? '');
                            }

                            // Navigate to guide homepage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GHomePage(
                                  selectedSearch: null,
                                  userId: userCredential.user?.uid ?? '',
                                ),
                              ),
                            );

                            // Store additional guide details in Firestore
                            await FirebaseFirestore.instance
                                .collection('guides')
                                .doc(userCredential.user?.uid)
                                .set({
                              'name': _nameController.text.trim(),
                              'phone': _phoneController.text.trim(),
                              'aadhaar': _aadhaarController.text.trim(),
                              'address': _addressController.text.trim(),
                              'email': email,
                              'imageUrl': imageUrl, // Store the image URL
                              'isUser': isUser,
                            });
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error: ${e.toString()}'),
                            ));
                          }
                        },
                        child: Text('SIGN UP',
                            style: TextStyle(color: Color(0xFF235537), fontSize: 25.00)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFDCD0A1),
                          textStyle: TextStyle(color: Color(0xFF235537)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller,
      {bool isPassword = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Color(0xFFF3E5B5).withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
