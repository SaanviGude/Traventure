import 'package:flutter/material.dart';

import 'homepage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/AppHS.jpeg', // Path to your image
                fit: BoxFit.cover, // Make the image cover the entire background
              ),
            ),

            // Your content on top of the background
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Color(0xFF315E3C),
                    leading:
                    IconButton(
                      icon: const Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),

                    title: Text(
                      'PROFILE',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 24,
                        fontFamily: 'Arial', // Use any font you prefer
                        letterSpacing: 2.0,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  Expanded(

                    child: Center(
                      child:Padding(padding:EdgeInsets.only(top:10),
                        child: Container(

                          width: 350,
                          height: 600,
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'USER-ID: 12345',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Arial',
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Details:',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                              SizedBox(height: 20),
                              _buildDetailRow(Icons.person, 'Sean Charles'),
                              _buildDetailRow(Icons.phone, '9155191432'),
                              _buildDetailRow(Icons.perm_identity, 'AID 1234-1234-1234'),
                              _buildDetailRow(
                                Icons.location_on,
                                'Old Sulabh International\nPorvorim, Bardez\nGoa, 403521',
                              ),
                              _buildDetailRow(Icons.email, 'seancharles@yahoo.in'),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF315F3C), // Button color
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'EDIT',
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
                      ),),////
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String detail) {
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
            child: Text(
              detail,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//448,998