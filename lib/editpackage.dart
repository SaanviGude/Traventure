import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class EditPackagePage extends StatefulWidget {
  final String? userId;
  final String? imageUrl;
  final String title;
  final double price;
  final String days;
  final String rating;
  final String description;

  EditPackagePage({
    required this.userId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.days,
    required this.rating,
    required this.description,
  });

  @override
  _EditPackagePageState createState() => _EditPackagePageState();
}

class _EditPackagePageState extends State<EditPackagePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with existing data
    _titleController.text = widget.title;
    _priceController.text = widget.price.toString();
    _daysController.text = widget.days;
    _ratingController.text = widget.rating;
    _descriptionController.text = widget.description;
    _imageUrl = widget.imageUrl;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future<String?> _uploadImageToStorage() async {
    if (_imageBytes == null) return _imageUrl;

    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageRef =
      FirebaseStorage.instance.ref().child('packages/$fileName');
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

  Future<void> _savePackage() async {
    double? price = double.tryParse(_priceController.text);

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid price.')),
      );
      return;
    }

    // Upload the new image if selected, or use the existing image URL
    String? imageUrl = await _uploadImageToStorage();

    await FirebaseFirestore.instance
        .collection('packages')
        .doc(widget.userId)
        .update({
      'name': _titleController.text,
      'price': price,
      'days': _daysController.text,
      'rating': _ratingController.text,
      'description': _descriptionController.text,
      'image_url': imageUrl, // Update with new or existing image URL
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Package updated successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Package'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      : (_imageUrl != null
                      ? Image.network(_imageUrl!)
                      : Center(child: Text('Tap to select an image'))),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(_titleController, 'Package Title'),
              SizedBox(height: 10),
              _buildTextField(_priceController, 'Price', isNumeric: true),
              SizedBox(height: 10),
              _buildTextField(_daysController, 'Duration (Days)'),
              SizedBox(height: 10),
              _buildTextField(_ratingController, 'Rating'),
              SizedBox(height: 10),
              _buildTextField(_descriptionController, 'Description'),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _savePackage,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Color(0xFF5E8953),
                  ),
                  child: Text('Save', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumeric = false}) {
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
