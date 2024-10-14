/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'dart:io'; // To handle the image file
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

  File? _image; // To store the selected image
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // For web, read the file as a blob and create a URL
      final reader = html.FileReader();
      reader.readAsDataUrl(html.File(pickedFile.path));
      reader.onLoadEnd.listen((event) {
        setState(() {
          // Use the reader.result which gives a base64 URL
          _imageUrl = reader.result as String;
        });
      });
    }
  }
  Future<void> _addPackage() async {
    await FirebaseFirestore.instance.collection('packages').add({
      'name': _nameController.text,
      'price': _priceController.text,
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
    });
    Navigator.pop(context); // Navigate back after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Package'),backgroundColor:  Color(
          0xFF4D8C53),),
      backgroundColor: Color(0xFFDCD0A1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF), // Light cream color for the box
                borderRadius: BorderRadius.circular(25),
              ),
           child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Package Name'),

            ),),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF), // Light cream color for the box
            borderRadius: BorderRadius.circular(25),
          ),
            child:TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF), // Light cream color for the box
            borderRadius: BorderRadius.circular(25),
          ),
          child:
            TextField(
              controller: _daysController,
              decoration: InputDecoration(labelText: 'Duration (Days)'),
            ),),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF), // Light cream color for the box
            borderRadius: BorderRadius.circular(25),
          ),
          child:
            TextField(
              controller: _ratingController,
              decoration: InputDecoration(labelText: 'Rating'),
            ),),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF), // Light cream color for the box
            borderRadius: BorderRadius.circular(25),
          ),
          child:

            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage, // Open image picker when tapped
              child: Container(
                width: double.infinity,
                height: 200,

                decoration: BoxDecoration(
                  color:Color(0xFFEDEDEA),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),

                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _image!,
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
}*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
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


