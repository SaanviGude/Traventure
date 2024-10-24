/*import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final String packageName;

  BookingPage({required this.packageName});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int numberOfTravelers = 1;  // Default number of travelers
  List<Map<String, dynamic>> travelersInfo = [];  // To store travelers' information

  @override
  void initState() {
    super.initState();
    // Initialize traveler info with one traveler
    travelersInfo = List.generate(numberOfTravelers, (index) => {
      'name': '',
      'age': '',
      'gender': 'Male',  // Default gender
      'aadhar': '',
      'phone': '',
    });
  }

  // Method to update the number of travelers and generate the fields accordingly
  void updateNumberOfTravelers(int count) {
    setState(() {
      numberOfTravelers = count;
      travelersInfo = List.generate(count, (index) => {
        'name': '',
        'age': '',
        'gender': 'Male',
        'aadhar': '',
        'phone': '',
      });
    });
  }

  // Method to handle the submission of the booking form
  void submitBooking() {
    print('Booking details:');
    for (int i = 0; i < travelersInfo.length; i++) {
      print('Traveler ${i + 1}: ${travelersInfo[i]}');
    }
    // Add your booking logic here (e.g., API call, saving to database)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.packageName}'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for the number of travelers
            Text(
              'Number of Travelers:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter number of travelers',
              ),
              onChanged: (value) {
                int? count = int.tryParse(value);
                if (count != null && count > 0) {
                  updateNumberOfTravelers(count);
                }
              },
            ),
            SizedBox(height: 20),

            // Generate traveler input fields dynamically
            Column(
              children: List.generate(numberOfTravelers, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Traveler ${index + 1} Information:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Name input
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['name'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Age input
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['age'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Gender selection
                    DropdownButtonFormField<String>(
                      value: travelersInfo[index]['gender'],
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                          .toList(),
                      onChanged: (value) {
                        travelersInfo[index]['gender'] = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gender',
                      ),
                    ),
                    SizedBox(height: 10),
                    // Aadhar number input
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Aadhar No.',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['aadhar'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Phone number input
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone No.',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['phone'] = value;
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),
            ),

            // "Submit Booking" button
            Center(
              child: ElevatedButton(
                onPressed: submitBooking,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Color(0xFF5E8953),
                ),
                child: Text(
                  'Submit Booking',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//1st code
*/


//2nd code

/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'payment.dart';
class BookingPage extends StatefulWidget {
  final String packageName;
  final int price;
  // final String? selectedSearch;
  final String? userId;
  BookingPage({required this.packageName,required this.userId,required this.price});


  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int numberOfTravelers = 1;  // Default number of travelers
  List<Map<String, dynamic>> travelersInfo = [];  // To store travelers' information

  @override
  void initState() {
    super.initState();
    // Initialize traveler info with one traveler
    travelersInfo = List.generate(numberOfTravelers, (index) => {
      'name': '',
      'age': '',
      'gender': 'Male',  // Default gender
      'aadhar': '',
      'phone': '',
    });
  }

  // Method to update the number of travelers and generate the fields accordingly
  void updateNumberOfTravelers(int count) {
    setState(() {
      numberOfTravelers = count;
      travelersInfo = List.generate(count, (index) => {
        'name': '',
        'age': '',
        'gender': 'Male',
        'aadhar': '',
        'phone': '',
      });
    });
  }

  // Method to handle the submission of the booking form
  /* void submitBooking() {
    print('Booking details:');
    for (int i = 0; i < travelersInfo.length; i++) {
      print('Traveler ${i + 1}: ${travelersInfo[i]}');
    }
    // Add your booking logic here (e.g., API call, saving to database)
  }
*/

  void submitBooking() {
    // Navigate to the Payment Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          userId: FirebaseAuth.instance.currentUser?.uid,
          packageName: widget.packageName,
          travelersInfo: travelersInfo, // Pass the travelers' information
          numberOfTravelers: numberOfTravelers,
          price: widget.price,// Pass the number of travelers
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.packageName}'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for the number of travelers
            Text(
              'Number of Travelers:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter number of travelers',
              ),
              onChanged: (value) {
                int? count = int.tryParse(value);
                if (count != null && count > 0) {
                  updateNumberOfTravelers(count);
                }
              },
            ),
            SizedBox(height: 20),

            // Generate traveler input fields dynamically
            Column(
              children: List.generate(numberOfTravelers, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Traveler ${index + 1} Information:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Name input
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['name'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Age input
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['age'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Gender selection
                    DropdownButtonFormField<String>(
                      value: travelersInfo[index]['gender'],
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                          .toList(),
                      onChanged: (value) {
                        travelersInfo[index]['gender'] = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gender',
                      ),
                    ),
                    SizedBox(height: 10),
                    // Aadhar number input
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Aadhar No.',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['aadhar'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Phone number input
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone No.',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['phone'] = value;
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),
            ),

            // "Submit Booking" button
            Center(
              child: ElevatedButton(
                onPressed: submitBooking,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Color(0xFF5E8953),
                ),
                child: Text(
                  'Submit Booking',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//3rd code  correct
 */


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'payment.dart';
class BookingPage extends StatefulWidget {
  final String packageName;
  final double price;
  // final String? selectedSearch;
  final String? userId;
  BookingPage({required this.packageName,required this.userId,required this.price});


  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int numberOfTravelers = 1;  // Default number of travelers
  List<Map<String, dynamic>> travelersInfo = [];  // To store travelers' information

  @override
  void initState() {
    super.initState();
    // Initialize traveler info with one traveler
    travelersInfo = List.generate(numberOfTravelers, (index) => {
      'name': '',
      'age': '',
      'gender': 'Male',  // Default gender
      'aadhar': '',
      'phone': '',
    });
  }

  // Method to update the number of travelers and generate the fields accordingly
  void updateNumberOfTravelers(int count) {
    setState(() {
      numberOfTravelers = count;
      travelersInfo = List.generate(count, (index) => {
        'name': '',
        'age': '',
        'gender': 'Male',
        'aadhar': '',
        'phone': '',
      });
    });
  }

  // Method to handle the submission of the booking form
  /* void submitBooking() {
    print('Booking details:');
    for (int i = 0; i < travelersInfo.length; i++) {
      print('Traveler ${i + 1}: ${travelersInfo[i]}');
    }
    // Add your booking logic here (e.g., API call, saving to database)
  }
*/

  //trying upi
  void submitBooking() {
    // Navigate to the Payment Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          userId: FirebaseAuth.instance.currentUser?.uid,
          packageName: widget.packageName,
          travelersInfo: travelersInfo, // Pass the travelers' information
          numberOfTravelers: numberOfTravelers,
          price: widget.price,// Pass the number of travelers
        ),
      ),
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
          'Book ${widget.packageName}',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for the number of travelers
            Text(
              'Number of Travelers:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter number of travelers',
              ),
              onChanged: (value) {
                int? count = int.tryParse(value);
                if (count != null && count > 0) {
                  updateNumberOfTravelers(count);
                }
              },
            ),
            SizedBox(height: 20),

            // Generate traveler input fields dynamically
            Column(
              children: List.generate(numberOfTravelers, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Traveler ${index + 1} Information:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Name input
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['name'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Age input
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['age'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Gender selection
                    DropdownButtonFormField<String>(
                      value: travelersInfo[index]['gender'],
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                          .toList(),
                      onChanged: (value) {
                        travelersInfo[index]['gender'] = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gender',
                      ),
                    ),
                    SizedBox(height: 10),
                    // Aadhar number input
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Aadhar No.',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['aadhar'] = value;
                      },
                    ),
                    SizedBox(height: 10),
                    // Phone number input
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone No.',
                      ),
                      onChanged: (value) {
                        travelersInfo[index]['phone'] = value;
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),
            ),

            // "Submit Booking" button
            Center(
              child: ElevatedButton(
                onPressed: submitBooking,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Color(0xFF5E8953),
                ),
                child: Text(
                  'Submit Booking',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

